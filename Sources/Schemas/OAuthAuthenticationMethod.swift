import Foundation

/// The authentication method to use for OAuth token requests
public enum OAuthAuthenticationMethod: String, Codable, Hashable, CaseIterable, Sendable {
    /// Basic Auth with credentials in Authorization header
    case basic
    /// Credentials in request body (default)
    case post
}