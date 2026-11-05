import Foundation

/// Audio format for both directions. Audio is mono and base64-encoded in each message.
/// Only `PCM_8000` and `MULAW_8000` are supported. `PCM_16000` and `PCM_44100` are rejected
/// with an `invalid_audio_format` error.
public enum AudioFormat: String, Codable, Hashable, CaseIterable, Sendable {
    /// Not supported. PCM 16-bit little-endian, 44.1 kHz.
    case pcm44100 = "PCM_44100"
    /// Not supported. PCM 16-bit little-endian, 16 kHz.
    case pcm16000 = "PCM_16000"
    /// PCM 16-bit little-endian, 8 kHz.
    case pcm8000 = "PCM_8000"
    /// G.711 μ-law, 8 kHz.
    case mulaw8000 = "MULAW_8000"
}