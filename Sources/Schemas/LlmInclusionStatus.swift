import Foundation

/// Shown in Agent Designer as "Agent inclusion".
public enum LlmInclusionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case always = "ALWAYS"
    case whenRelevant = "WHEN_RELEVANT"
    /// A knowledge base's "Deactivate" action sets this, and "Activate" sets `WHEN_RELEVANT`.
    case never = "NEVER"
}