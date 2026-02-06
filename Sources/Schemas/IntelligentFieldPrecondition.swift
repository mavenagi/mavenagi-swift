import Foundation

/// A precondition based on the computed value of an intelligent field on the conversation.
/// 
/// Note: in early beta, only opt-in apps and organizations/agents can
/// specify intelligent field preconditions.  Otherwise, the request will be
/// rejected.
public struct IntelligentFieldPrecondition: Codable, Hashable, Sendable {
    /// The referenceId of the intelligent field.
    public let fieldReferenceId: String
    /// The appId of the intelligent field. If not provided, the calling appId will be used.
    public let fieldAppId: String?
    /// The condition to evaluate against the field's value.
    public let fieldCondition: IntelligentFieldCondition
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldReferenceId: String,
        fieldAppId: String? = nil,
        fieldCondition: IntelligentFieldCondition,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldReferenceId = fieldReferenceId
        self.fieldAppId = fieldAppId
        self.fieldCondition = fieldCondition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldReferenceId = try container.decode(String.self, forKey: .fieldReferenceId)
        self.fieldAppId = try container.decodeIfPresent(String.self, forKey: .fieldAppId)
        self.fieldCondition = try container.decode(IntelligentFieldCondition.self, forKey: .fieldCondition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldReferenceId, forKey: .fieldReferenceId)
        try container.encodeIfPresent(self.fieldAppId, forKey: .fieldAppId)
        try container.encode(self.fieldCondition, forKey: .fieldCondition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldReferenceId
        case fieldAppId
        case fieldCondition
    }
}