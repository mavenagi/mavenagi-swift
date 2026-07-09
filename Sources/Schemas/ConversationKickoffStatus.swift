import Foundation

public enum ConversationKickoffStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case success = "SUCCESS"
    case failed = "FAILED"
}