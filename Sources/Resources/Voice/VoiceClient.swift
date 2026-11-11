import Foundation

public final class VoiceClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Creates a short-lived session token for authenticating voice connections.
    /// 
    /// Supports two token types:
    /// - **webrtc**: A token for browser-based WebRTC calls. The `transport` field selects the token format:
    ///   a token for the Maven telephony gateway (default) or a Twilio access token.
    /// - **websocket**: An ES256 JWT for direct WebSocket connections to /v1/realtime/conversations
    /// 
    /// Session tokens are required before establishing any voice connection.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func sessionToken(request: VoiceSessionTokenRequest, requestOptions: RequestOptions? = nil) async throws -> VoiceSessionTokenResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/voice/session-token",
            body: request,
            requestOptions: requestOptions,
            responseType: VoiceSessionTokenResponse.self
        )
    }
}