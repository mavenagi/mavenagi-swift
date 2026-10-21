import Foundation

/// Why the agent could not answer. Recorded when the response is generated, alongside its `status`.
/// 
/// * `CONTENT_SAFETY_ISSUE`: The user's message failed the content safety check, so the agent did not answer it. The response is the agent's content safety reply. `status` is `REJECTED`.
/// * `FAILED_TO_RETRIEVE_KNOWLEDGE`: Knowledge retrieval failed, so the agent did not answer. The response is a generic error message. `status` is `FAILED`.
/// * `FAILED_TO_RETRIEVE_ACTIONS`: Action retrieval failed, so the agent did not answer. The response is a generic error message. `status` is `FAILED`.
public enum BotMessageStatusReason: String, Codable, Hashable, CaseIterable, Sendable {
    case contentSafetyIssue = "CONTENT_SAFETY_ISSUE"
    case failedToRetrieveKnowledge = "FAILED_TO_RETRIEVE_KNOWLEDGE"
    case failedToRetrieveActions = "FAILED_TO_RETRIEVE_ACTIONS"
}