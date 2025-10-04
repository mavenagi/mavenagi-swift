import Foundation

public enum DeliveryStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case delivered = "DELIVERED"
    case failed = "FAILED"
    case queued = "QUEUED"
}