import Foundation

public enum DeviceType: String, Codable, Hashable, CaseIterable, Sendable {
    case desktop = "DESKTOP"
    case mobile = "MOBILE"
    case tablet = "TABLET"
    case other = "OTHER"
}