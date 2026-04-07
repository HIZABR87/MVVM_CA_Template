import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mvvm_architecture_template/core/hive/hive_boxes.dart';

abstract class ITokenService {
  /// Persists the access token. Pass [expiresAt] so expiry checks work.
  Future<void> saveToken(String token, {DateTime? expiresAt});

  /// Persists the refresh token.
  Future<void> saveRefreshToken(String refreshToken);

  /// Returns the stored access token, or [null] if absent.
  String? getToken();

  /// Returns the stored refresh token, or [null] if absent.
  String? getRefreshToken();

  /// Returns the stored access-token expiry, or [null] if unknown.
  DateTime? getTokenExpiry();

  /// Removes access token, refresh token and expiry (use on logout).
  Future<void> clearTokens();

  /// [true] when a non-empty token is present **and** it has not expired.
  /// A 30-second buffer is applied to account for clock skew and latency.
  bool get isAuthenticated;

  /// [true] when the stored token is past (or within 30 s of) its expiry.
  /// Returns [false] when no expiry is stored (treat as still valid).
  bool get isTokenExpired;
}

@LazySingleton(as: ITokenService)
class TokenServiceImpl implements ITokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expiryKey = 'token_expiry';

  // 30-second buffer to refresh before the token actually expires.
  static const Duration _expiryBuffer = Duration(seconds: 30);

  // Hive box opened with AES-256 cipher in HiveDatabase.init().
  Box<String> get _authBox => Hive.box<String>(HiveBoxes.authorization);

  @override
  Future<void> saveToken(String token, {DateTime? expiresAt}) async {
    assert(_isValidJwt(token), 'saveToken: value does not look like a JWT');
    await _authBox.put(_accessTokenKey, token);
    if (expiresAt != null) {
      await _authBox.put(_expiryKey, expiresAt.toUtc().toIso8601String());
    } else {
      await _authBox.delete(_expiryKey);
    }
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) =>
      _authBox.put(_refreshTokenKey, refreshToken);

  @override
  String? getToken() => _authBox.get(_accessTokenKey);

  @override
  String? getRefreshToken() => _authBox.get(_refreshTokenKey);

  @override
  DateTime? getTokenExpiry() {
    final raw = _authBox.get(_expiryKey);
    if (raw == null) return null;
    return DateTime.tryParse(raw)?.toLocal();
  }

  @override
  Future<void> clearTokens() async {
    await _authBox.deleteAll([_accessTokenKey, _refreshTokenKey, _expiryKey]);
  }

  @override
  bool get isTokenExpired {
    final expiry = getTokenExpiry();
    if (expiry == null) return false; // unknown expiry → assume valid
    return DateTime.now().isAfter(expiry.subtract(_expiryBuffer));
  }

  @override
  bool get isAuthenticated {
    final token = getToken();
    if (token == null || token.isEmpty) return false;
    return !isTokenExpired;
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  /// Validates that [value] has the three Base64-URL segments of a JWT.
  /// Not a cryptographic check — just a sanity guard at the boundary.
  static bool _isValidJwt(String value) {
    final parts = value.split('.');
    return parts.length == 3 && parts.every((p) => p.isNotEmpty);
  }
}
