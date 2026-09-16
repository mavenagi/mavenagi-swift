import Foundation

public enum SystemEventName: String, Codable, Hashable, CaseIterable, Sendable {
    /// An app was installed
    case appInstalled = "APP_INSTALLED"
    /// An app was uninstalled
    case appUninstalled = "APP_UNINSTALLED"
    /// An app was updated
    case appUpdated = "APP_UPDATED"
    /// An outbound notification was sent to a user
    case notificationSent = "NOTIFICATION_SENT"
    /// An outbound notification reached the user
    case notificationDelivered = "NOTIFICATION_DELIVERED"
    /// An outbound notification could not be delivered
    case notificationFailed = "NOTIFICATION_FAILED"
    /// An external system was connected
    case integrationConnected = "INTEGRATION_CONNECTED"
    /// An external system was disconnected
    case integrationDisconnected = "INTEGRATION_DISCONNECTED"
    /// A data sync with an external system began
    case syncStarted = "SYNC_STARTED"
    /// A data sync with an external system finished
    case syncCompleted = "SYNC_COMPLETED"
    /// A data sync with an external system failed
    case syncFailed = "SYNC_FAILED"
}