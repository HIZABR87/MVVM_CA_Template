/// Represents the payload returned by a token-refresh endpoint.
class TokenPair {
  final String accessToken;
  final String? refreshToken;

  /// The moment at which [accessToken] expires.
  /// Null means the caller could not determine the expiry (treat as unknown).
  final DateTime? expiresAt;

  const TokenPair({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });
}

/// Contract for exchanging a refresh token for a new [TokenPair].
///
/// Implement this interface in the auth feature and register it with GetIt:
///
/// ```dart
/// @LazySingleton(as: ITokenRefreshService)
/// class AuthTokenRefreshService implements ITokenRefreshService { ... }
/// ```
///
/// The [TokenInterceptor] depends on this interface; if no implementation is
/// registered the interceptor skips the silent-refresh path and clears the
/// tokens on 401 instead.
abstract class ITokenRefreshService {
  /// Calls the backend refresh endpoint and returns fresh tokens.
  /// Throws on network failure or when the refresh token is rejected (HTTP 401/403).
  Future<TokenPair> refresh(String refreshToken);
}
