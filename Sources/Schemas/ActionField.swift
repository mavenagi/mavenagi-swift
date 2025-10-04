import Foundation

public enum ActionField: String, Codable, Hashable, CaseIterable, Sendable {
    case appId = "AppId"
    case name = "Name"
    case llmInclusionStatus = "LlmInclusionStatus"
    case userInteractionRequired = "UserInteractionRequired"
    case createdAt = "CreatedAt"
}