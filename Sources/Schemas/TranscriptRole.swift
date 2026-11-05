import Foundation

public enum TranscriptRole: String, Codable, Hashable, CaseIterable, Sendable {
    case user
    case agent
}