import Foundation

public enum ConversationField: String, Codable, Hashable, CaseIterable, Sendable {
    case category = "Category"
    case firstResponseTime = "FirstResponseTime"
    case handleTime = "HandleTime"
    case humanAgents = "HumanAgents"
    case humanAgentsWithInserts = "HumanAgentsWithInserts"
    case app = "App"
    case sentiment = "Sentiment"
    case qualityReason = "QualityReason"
    case resolutionStatus = "ResolutionStatus"
    case resolvedByMaven = "ResolvedByMaven"
    case quality = "Quality"
    case users = "Users"
    case responseLength = "ResponseLength"
    case thumbsUpCount = "ThumbsUpCount"
    case thumbsDownCount = "ThumbsDownCount"
    case insertCount = "InsertCount"
    case tags = "Tags"
    case userMessageCount = "UserMessageCount"
    case botMessageCount = "BotMessageCount"
    case languages = "Languages"
    case actions = "Actions"
    case incompleteActions = "IncompleteActions"
    case erroredActions = "ErroredActions"
    case actionExecutionCount = "ActionExecutionCount"
    case actionErrorCount = "ActionErrorCount"
    case charters = "Charters"
    case sources = "Sources"
    case createdAt = "CreatedAt"
    case predictedNps = "PredictedNPS"
    case csat = "Csat"
    case organizationId = "OrganizationId"
    case agentId = "AgentId"
    /// The environment configured on the agent: DEMO, STAGING, or PRODUCTION. Constant within a
    /// single agent, so it only separates conversations on a cross-agent request.
    case agentEnvironment = "AgentEnvironment"
    case inboxItems = "InboxItems"
    case involvedApps = "InvolvedApps"
    /// In development, part of agent versioning. The agent variant the conversation is pinned
    /// to (its `variantId`). A conversation from before the agent's conversations were pinned
    /// has none; grouping puts those under `BEFORE_VERSIONING`. In a table row a variant is an
    /// `entityId` value and `BEFORE_VERSIONING` a `string` value.
    case variant = "Variant"
    /// Selects an intelligent field rather than a built-in conversation field.
    /// When used, `intelligentFieldId` must also be set to identify which field.
    /// Grouping by it splits that one field's conversations by value; to split conversations by
    /// which fields they have, use `IntelligentFields`.
    case intelligentField = "IntelligentField"
    /// Groups conversations by each intelligent field that has a value on them: one bucket per
    /// field, keyed by the field as an `entityId` value. A conversation with three fields counts
    /// once under each, as with `Actions`. A field counts when the conversation has a value for
    /// it, an undetermined one included: the same conversations an `intelligentFields`
    /// `EXISTS` condition matches. Only conversation-level fields are on a conversation.
    /// 
    /// Unlike `IntelligentField`, it takes no `intelligentFieldId` and doesn't look at values.
    /// Combine it with `Variant` to see which fields each variant's conversations have.
    /// 
    /// It only works as a grouping: a metric targeting it, such as a `distinctCount`, is
    /// rejected with a 400.
    case intelligentFields = "IntelligentFields"
}