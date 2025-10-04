import Foundation

/// The type of feedback
public enum FeedbackType: String, Codable, Hashable, CaseIterable, Sendable {
    case thumbsUp = "THUMBS_UP"
    case thumbsDown = "THUMBS_DOWN"
    case insert = "INSERT"
    case handoff = "HANDOFF"
}