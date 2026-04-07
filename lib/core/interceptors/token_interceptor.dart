import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:injectable/injectable.dart';
import 'package:mvvm_architecture_template/core/api/headers_constants.dart';
import 'package:mvvm_architecture_template/core/routes/app_routes.dart';
import 'package:mvvm_architecture_template/core/storage/token_refresh_service.dart';
import 'package:mvvm_architecture_template/core/storage/token_service.dart';
import 'package:mvvm_architecture_template/injectable_config.dart';

/// A Dio interceptor that:
///
/// 1. **Attaches** `Authorization: Bearer <token>` to every outgoing request.
/// 2. **Proactively refreshes** the token before it expires (if [ITokenRefreshService]
///    is registered in GetIt).
/// 3. **Silently refreshes** on HTTP 401, queues concurrent requests, retries
///    them with the new token, and falls back to logout if refresh fails.
@LazySingleton()
class TokenInterceptor extends Interceptor {
  final ITokenService _tokenService;
  final Dio _dio;

  /// Completer used as a mutex: non-null while a refresh is in flight.
  /// All 401ing requests wait on this future before they retry.
  Completer<void>? _refreshCompleter;

  TokenInterceptor(this._tokenService, this._dio);

  // ── onRequest ─────────────────────────────────────────────────────────────

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip the auth header for already-retried requests (avoid double-header).
    if (options.extra['_retried'] == true) {
      handler.next(options);
      return;
    }

    // Proactive refresh: if token is close to expiry, refresh before sending.
    if (_tokenService.isTokenExpired && _tokenService.getRefreshToken() != null) {
      await _attemptRefresh();
    }

    final token = _tokenService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers[HeadersConstants.authorization] =
          '${HeadersConstants.bearer}$token';
    }
    handler.next(options);
  }

  // ── onError ───────────────────────────────────────────────────────────────

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final is401 = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['_retried'] == true;

    if (!is401 || alreadyRetried) {
      handler.next(err);
      return;
    }

    // ── If a refresh is already running, wait for it then retry. ─────────
    if (_refreshCompleter != null) {
      try {
        await _refreshCompleter!.future;
        handler.resolve(await _retry(err.requestOptions));
      } catch (_) {
        _logout();
        handler.next(err);
      }
      return;
    }

    // ── This request is first to 401 → trigger the refresh. ───────────────
    final succeeded = await _attemptRefresh();
    if (succeeded) {
      try {
        handler.resolve(await _retry(err.requestOptions));
      } catch (retryErr) {
        handler.next(err);
      }
    } else {
      _logout();
      handler.next(err);
    }
  }

  // ── helpers ───────────────────────────────────────────────────────────────

  /// Tries to obtain a fresh [TokenPair] via [ITokenRefreshService].
  /// Returns [true] on success, [false] otherwise.
  /// Sets up [_refreshCompleter] so concurrent callers can wait.
  Future<bool> _attemptRefresh() async {
    // Resolve ITokenRefreshService lazily — it may not exist in every project.
    ITokenRefreshService? refreshService;
    try {
      refreshService = getIt<ITokenRefreshService>();
    } catch (_) {
      // Not registered — skip silent refresh entirely.
      return false;
    }

    final refreshToken = _tokenService.getRefreshToken();
    if (refreshToken == null) return false;

    _refreshCompleter = Completer<void>();
    try {
      final pair = await refreshService.refresh(refreshToken);
      await _tokenService.saveToken(pair.accessToken, expiresAt: pair.expiresAt);
      if (pair.refreshToken != null) {
        await _tokenService.saveRefreshToken(pair.refreshToken!);
      }
      _refreshCompleter!.complete();
      return true;
    } catch (_) {
      _refreshCompleter!.completeError(_);
      await _tokenService.clearTokens();
      return false;
    } finally {
      _refreshCompleter = null;
    }
  }

  /// Clones [options], marks it as retried, attaches the fresh token, and
  /// executes it through the same [_dio] instance (bypasses re-interception
  /// of the 401 handler via the `_retried` extra flag).
  Future<Response<dynamic>> _retry(RequestOptions options) {
    final token = _tokenService.getToken();
    final opts = options.copyWith(
      extra: {...options.extra, '_retried': true},
    );
    if (token != null && token.isNotEmpty) {
      opts.headers[HeadersConstants.authorization] =
          '${HeadersConstants.bearer}$token';
    }
    return _dio.fetch(opts);
  }

  void _logout() {
    _tokenService.clearTokens();
    // Navigate to login, clearing the entire back-stack.
    // TODO: replace AppRoutes.splashRoute with your login route.
    Get.offAllNamed(AppRoutes.splashRoute);
  }
}
