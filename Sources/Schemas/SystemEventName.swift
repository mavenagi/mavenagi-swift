import Foundation

public enum SystemEventName: String, Codable, Hashable, CaseIterable, Sendable {
    /// An app was installed
    case appInstalled = "APP_INSTALLED"
    /// An app was uninstalled
    case appUninstalled = "APP_UNINSTALLED"
    /// An app was updated
    case appUpdated = "APP_UPDATED"
}