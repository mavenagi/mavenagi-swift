import Foundation

public enum SourceType: String, Codable, Hashable, CaseIterable, Sendable {
    case web = "WEB"
    case api = "API"
    case system = "SYSTEM"
}