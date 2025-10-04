import Foundation

public enum LlmInclusionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case always = "ALWAYS"
    case whenRelevant = "WHEN_RELEVANT"
    case never = "NEVER"
}