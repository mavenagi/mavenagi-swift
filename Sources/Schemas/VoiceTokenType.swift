import Foundation

public enum VoiceTokenType: String, Codable, Hashable, CaseIterable, Sendable {
    case webrtc
    case websocket
}