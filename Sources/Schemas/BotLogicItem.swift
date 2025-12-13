import Foundation

public enum BotLogicItem: Codable, Hashable, Sendable {
    case actions(Actions)
    case form(Form)
    case knowledge(Knowledge)
    case safety(Safety)
    case segments(Segments)
    case user(User)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "actions":
            self = .actions(try Actions(from: decoder))
        case "form":
            self = .form(try Form(from: decoder))
        case "knowledge":
            self = .knowledge(try Knowledge(from: decoder))
        case "safety":
            self = .safety(try Safety(from: decoder))
        case "segments":
            self = .segments(try Segments(from: decoder))
        case "user":
            self = .user(try User(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .actions(let data):
            try data.encode(to: encoder)
        case .form(let data):
            try data.encode(to: encoder)
        case .knowledge(let data):
            try data.encode(to: encoder)
        case .safety(let data):
            try data.encode(to: encoder)
        case .segments(let data):
            try data.encode(to: encoder)
        case .user(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Knowledge: Codable, Hashable, Sendable {
        public let type: String = "knowledge"
        public let knowledgeReviewed: [BotLogicKnowledgeDetail]
        public let knowledgeUtilized: [BotLogicKnowledgeDetail]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            knowledgeReviewed: [BotLogicKnowledgeDetail],
            knowledgeUtilized: [BotLogicKnowledgeDetail],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.knowledgeReviewed = knowledgeReviewed
            self.knowledgeUtilized = knowledgeUtilized
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.knowledgeReviewed = try container.decode([BotLogicKnowledgeDetail].self, forKey: .knowledgeReviewed)
            self.knowledgeUtilized = try container.decode([BotLogicKnowledgeDetail].self, forKey: .knowledgeUtilized)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.knowledgeReviewed, forKey: .knowledgeReviewed)
            try container.encode(self.knowledgeUtilized, forKey: .knowledgeUtilized)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case knowledgeReviewed
            case knowledgeUtilized
        }
    }

    public struct Actions: Codable, Hashable, Sendable {
        public let type: String = "actions"
        public let actionsReviewed: [BotLogicActionReviewedDetail]
        public let actionsExecuted: [BotLogicActionExecutedDetail]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            actionsReviewed: [BotLogicActionReviewedDetail],
            actionsExecuted: [BotLogicActionExecutedDetail],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.actionsReviewed = actionsReviewed
            self.actionsExecuted = actionsExecuted
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.actionsReviewed = try container.decode([BotLogicActionReviewedDetail].self, forKey: .actionsReviewed)
            self.actionsExecuted = try container.decode([BotLogicActionExecutedDetail].self, forKey: .actionsExecuted)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.actionsReviewed, forKey: .actionsReviewed)
            try container.encode(self.actionsExecuted, forKey: .actionsExecuted)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case actionsReviewed
            case actionsExecuted
        }
    }

    public struct Form: Codable, Hashable, Sendable {
        public let type: String = "form"
        public let actionParameters: [String: ActionExecutionParamValue]
        public let executionResult: String?
        public let executionError: String?
        public let actionId: EntityIdWithoutAgent
        public let actionName: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            actionParameters: [String: ActionExecutionParamValue],
            executionResult: String? = nil,
            executionError: String? = nil,
            actionId: EntityIdWithoutAgent,
            actionName: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.actionParameters = actionParameters
            self.executionResult = executionResult
            self.executionError = executionError
            self.actionId = actionId
            self.actionName = actionName
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.actionParameters = try container.decode([String: ActionExecutionParamValue].self, forKey: .actionParameters)
            self.executionResult = try container.decodeIfPresent(String.self, forKey: .executionResult)
            self.executionError = try container.decodeIfPresent(String.self, forKey: .executionError)
            self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
            self.actionName = try container.decode(String.self, forKey: .actionName)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.actionParameters, forKey: .actionParameters)
            try container.encodeIfPresent(self.executionResult, forKey: .executionResult)
            try container.encodeIfPresent(self.executionError, forKey: .executionError)
            try container.encode(self.actionId, forKey: .actionId)
            try container.encode(self.actionName, forKey: .actionName)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case actionParameters
            case executionResult
            case executionError
            case actionId
            case actionName
        }
    }

    public struct Safety: Codable, Hashable, Sendable {
        public let type: String = "safety"
        public let safetyCheckPassed: Bool
        /// If the safety check failed, this contains more details about the failure.
        public let report: SafetyCheckReport?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            safetyCheckPassed: Bool,
            report: SafetyCheckReport? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.safetyCheckPassed = safetyCheckPassed
            self.report = report
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.safetyCheckPassed = try container.decode(Bool.self, forKey: .safetyCheckPassed)
            self.report = try container.decodeIfPresent(SafetyCheckReport.self, forKey: .report)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.safetyCheckPassed, forKey: .safetyCheckPassed)
            try container.encodeIfPresent(self.report, forKey: .report)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case safetyCheckPassed
            case report
        }
    }

    public struct User: Codable, Hashable, Sendable {
        public let type: String = "user"
        public let userData: [String: String]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            userData: [String: String],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.userData = userData
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.userData = try container.decode([String: String].self, forKey: .userData)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.userData, forKey: .userData)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case userData
        }
    }

    public struct Segments: Codable, Hashable, Sendable {
        public let type: String = "segments"
        public let matchingSegmentIds: [EntityId]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            matchingSegmentIds: [EntityId],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.matchingSegmentIds = matchingSegmentIds
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.matchingSegmentIds = try container.decode([EntityId].self, forKey: .matchingSegmentIds)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.matchingSegmentIds, forKey: .matchingSegmentIds)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case matchingSegmentIds
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}