import Foundation

public struct ActionFilter: Codable, Hashable, Sendable {
    /// Filter by instructions
    public let instructions: String?
    /// Filter by action name
    public let name: String?
    /// Filter by LLM inclusion status
    public let llmInclusionStatuses: [LlmInclusionStatus]?
    /// Filter by app IDs
    public let appIds: [String]?
    /// Filter by user interaction required
    public let userInteractionRequired: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        instructions: String? = nil,
        name: String? = nil,
        llmInclusionStatuses: [LlmInclusionStatus]? = nil,
        appIds: [String]? = nil,
        userInteractionRequired: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.instructions = instructions
        self.name = name
        self.llmInclusionStatuses = llmInclusionStatuses
        self.appIds = appIds
        self.userInteractionRequired = userInteractionRequired
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.llmInclusionStatuses = try container.decodeIfPresent([LlmInclusionStatus].self, forKey: .llmInclusionStatuses)
        self.appIds = try container.decodeIfPresent([String].self, forKey: .appIds)
        self.userInteractionRequired = try container.decodeIfPresent(Bool.self, forKey: .userInteractionRequired)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.instructions, forKey: .instructions)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.llmInclusionStatuses, forKey: .llmInclusionStatuses)
        try container.encodeIfPresent(self.appIds, forKey: .appIds)
        try container.encodeIfPresent(self.userInteractionRequired, forKey: .userInteractionRequired)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case instructions
        case name
        case llmInclusionStatuses
        case appIds
        case userInteractionRequired
    }
}