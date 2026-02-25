import Foundation

public final class VoiceClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Creates a short-lived session token for authenticating voice connections.
    /// 
    /// Supports two token types:
    /// - **webrtc**: A Twilio-compatible access token for browser-based WebRTC calls
    /// - **websocket**: An RS256 JWT for direct WebSocket connections to /v1/voice/conversations
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