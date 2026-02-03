import Foundation

public enum AppVisibility: String, Codable, Hashable, CaseIterable, Sendable {
    case inDevelopment = "IN_DEVELOPMENT"
    case `private` = "PRIVATE"
    case `public` = "PUBLIC"
}