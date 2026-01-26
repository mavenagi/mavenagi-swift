import Foundation

public enum AudioFormat: String, Codable, Hashable, CaseIterable, Sendable {
    case pcm44100 = "PCM_44100"
    case pcm16000 = "PCM_16000"
    case pcm8000 = "PCM_8000"
    case mulaw8000 = "MULAW_8000"
}