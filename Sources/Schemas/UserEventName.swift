import Foundation

public enum UserEventName: String, Codable, Hashable, CaseIterable, Sendable {
    /// A button click occurred
    case buttonClicked = "BUTTON_CLICKED"
    /// A link was clicked
    case linkClicked = "LINK_CLICKED"
    /// The chat window was opened
    case chatOpened = "CHAT_OPENED"
    /// The chat window was closed
    case chatClosed = "CHAT_CLOSED"
    /// A text was inserted into a field
    case textInserted = "TEXT_INSERTED"
}