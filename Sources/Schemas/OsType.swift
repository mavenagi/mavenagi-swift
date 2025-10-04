import Foundation

public enum OsType: String, Codable, Hashable, CaseIterable, Sendable {
    case windows = "WINDOWS"
    case macos = "MACOS"
    case linux = "LINUX"
    case android = "ANDROID"
    case ios = "IOS"
    case other = "OTHER"
}