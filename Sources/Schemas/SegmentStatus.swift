import Foundation

public enum SegmentStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case active = "ACTIVE"
    case inactive = "INACTIVE"
}