import Foundation

public enum UserMessageResponseState: String, Codable, Hashable, CaseIterable, Sendable {
    case notAsked = "NOT_ASKED"
    case llmEnabled = "LLM_ENABLED"
    case llmDisabled = "LLM_DISABLED"
}