import Foundation

public enum InboxItemType: String, Codable, Hashable, CaseIterable, Sendable {
    /// The inbox item is a duplicate document.
    case duplicateDocument = "DUPLICATE_DOCUMENT"
    /// The inbox item is missing knowledge.
    case missingKnowledge = "MISSING_KNOWLEDGE"
    /// The inbox item is a custom api-provided inbox item.
    case custom = "CUSTOM"
}