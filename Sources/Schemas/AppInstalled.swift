import Foundation

public enum AppInstalled: String, Codable, Hashable, CaseIterable, Sendable {
    case installed = "INSTALLED"
    case notInstalled = "NOT_INSTALLED"
}