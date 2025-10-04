import Foundation

public enum AttachmentStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case pending = "PENDING"
    case processing = "PROCESSING"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
}