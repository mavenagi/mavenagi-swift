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
    /// A conversation was closed, by setting `open` to false through the conversation PATCH. `references` carries the conversation. Maven records it once it has finished analyzing the conversation (its summary, category and intelligent field values), so the conversation's data is final when the event arrives; that can be a little after the close.
    case conversationClosed = "CONVERSATION_CLOSED"
    /// The agent sent a visible reply in a conversation: a response or a suggestion. `references` carries the conversation, the message, the charters matched in the turn that produced this reply, and the actions the bot ran in that turn, failed attempts included. Actions the user submitted as a form, or was only offered, are not included. Each event covers its own reply's turn, not earlier ones. A `references` condition can name a charter, an action or a combination of them. `contextInfo.additionalData` carries the message's `botMessageType` (see `AdditionalDataKey`). Like `CONVERSATION_CLOSED`, it is recorded once Maven has finished analyzing the conversation through that reply.
    case botReplyCreated = "BOT_REPLY_CREATED"
    /// An intelligent field's value on a conversation or agent user was set or changed. `references` carries the field and the conversation or agent user the value belongs to; `contextInfo.additionalData` carries the new `value` and the `previousValue` (see `AdditionalDataKey`). A string value is written as is, a boolean or number as its text (`true`, `3`), and a multi-select's options as a JSON array. A key is absent when its value is undetermined or, for `previousValue`, when the field had no previous value.
    case intelligentFieldValueChanged = "INTELLIGENT_FIELD_VALUE_CHANGED"
}