import Foundation

/// Calculates the number of unique values in the specified field.
/// Supports fields with list values as well.
public struct FeedbackDistinctCount: Codable, Hashable, Sendable {
    /// All the distinct values of this field will be counted.
    public let targetField: FeedbackField
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        targetField: FeedbackField,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.targetField = targetField
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.targetField = try container.decode(FeedbackField.self, forKey: .targetField)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.targetField, forKey: .targetField)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case targetField
    }
}