import Foundation

/// Filter by properties of the intelligent field definition
public struct IntelligentFieldValueFieldFilter: Codable, Hashable, Sendable {
    /// Filter to specific fields by their entity IDs. OR semantics. Maximum 100 IDs.
    public let fieldIds: [EntityId]?
    /// Filter by field validation type (STRING, MULTILINE, MULTI_SELECT, BOOLEAN, NUMBER). OR semantics.
    public let validationTypes: [IntelligentFieldType]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldIds: [EntityId]? = nil,
        validationTypes: [IntelligentFieldType]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldIds = fieldIds
        self.validationTypes = validationTypes
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldIds = try container.decodeIfPresent([EntityId].self, forKey: .fieldIds)
        self.validationTypes = try container.decodeIfPresent([IntelligentFieldType].self, forKey: .validationTypes)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.fieldIds, forKey: .fieldIds)
        try container.encodeIfPresent(self.validationTypes, forKey: .validationTypes)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldIds
        case validationTypes
    }
}