import Foundation

/// The transport that carries a "webrtc" call.
public enum VoiceWebRtcTransport: String, Codable, Hashable, CaseIterable, Sendable {
    /// The Maven telephony gateway. The token is a gateway token.
    case gateway
    /// Twilio Voice. The token is a Twilio access token.
    case twilio
}