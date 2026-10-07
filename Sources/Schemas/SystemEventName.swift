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
    /// A conversation was closed, by setting `open` to false through the conversation PATCH. `references` carries the conversation.
    case conversationClosed = "CONVERSATION_CLOSED"
    /// An intelligent field's value on a conversation was set or changed. `references` carries the conversation and the field; `contextInfo.additionalData` carries the new `value` and the `previousValue` (see `AdditionalDataKey`). A string value is written as is, a boolean or number as its text (`true`, `3`), and a multi-select's options as a JSON array. A key is absent when its value is undetermined or, for `previousValue`, when the field had no previous value.
    case intelligentFieldValueChanged = "INTELLIGENT_FIELD_VALUE_CHANGED"
}