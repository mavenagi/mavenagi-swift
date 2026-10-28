import Foundation

public enum AgentUserField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CreatedAt"
    case updatedAt = "UpdatedAt"
    /// Whether the user is anonymous, as `isAnonymous` filters on. Groups as a `boolean` value.
    case anonymous = "Anonymous"
    /// Selects a user-level intelligent field. When used, `intelligentFieldId` must also be set
    /// to identify which field. Grouping by it splits that field's users by value; a user without
    /// a value for it is left out.
    case intelligentField = "IntelligentField"
}