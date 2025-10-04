import Foundation

/// The sentiment of the conversation
public enum Sentiment: String, Codable, Hashable, CaseIterable, Sendable {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case neutral = "NEUTRAL"
    case mixed = "MIXED"
    case unknown = "UNKNOWN"
}