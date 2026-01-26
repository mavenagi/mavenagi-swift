import Foundation

public final class AuthClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Creates a short-lived session token that can be used to authenticate 
    /// WebSocket connections. Session tokens are useful for client-side applications where 
    /// you don’t want to expose your API key.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func sessionToken(request: SessionTokenRequest, requestOptions: RequestOptions? = nil) async throws -> SessionTokenResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/auth/session-token",
            body: request,
            requestOptions: requestOptions,
            responseType: SessionTokenResponse.self
        )
    }
}