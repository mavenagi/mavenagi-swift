import Foundation

/// A JSON object matching a schema, returned as a `BotObjectResponse`.
public struct TextFormatJsonSchema: Codable, Hashable, Sendable {
    /// The required shape. Property names and their `description`s are what tell the agent how
    /// to fill each field, so name and describe them as you would for a reader.
    /// 
    /// The answer is enforced against this schema rather than merely guided by it, so the schema
    /// has to be one that can be enforced. Each rule is checked when the request arrives.
    /// 
    /// **Schema Requirements:**
    /// - Root type must be "object" with a non-empty `properties` map
    /// - Supported types: string, number, integer, boolean, object, array, null
    /// - Structural keywords only: properties, required, additionalProperties, items, anyOf, enum, const (with a sibling type), $defs/$ref, description. Value constraints such as pattern, format, minimum or minItems, and combinators such as oneOf, allOf and if/then/else, are not accepted
    /// - Required fields: All fields must be required (no optional properties). A value that may be absent is required with a type that includes `null`, so expect every property to come back, with `null` where it does not apply
    /// - Additional properties: Must be set to false
    /// 
    /// **Limits:**
    /// - Maximum nesting depth: 5 levels
    /// - Maximum total properties: 100
    /// - Maximum total string length: 15,000 characters
    /// - Maximum total enum values: 500
    /// 
    /// Recursive schemas are supported; a self-reference resolves against this schema. Describe
    /// the object as a whole with `description` below, and annotate individual fields with their
    /// own `description`.
    public let schema: JSONValue
    /// What the object as a whole is for, where a property's own `description` describes that one field. Takes precedence over a `description` at the root of the schema.
    /// Keep it to a description of the object. It is not a place to put instructions for the agent or per-request context — those belong in the agent's own configuration and in `text`.
    public let description: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        schema: JSONValue,
        description: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.schema = schema
        self.description = description
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.schema = try container.decode(JSONValue.self, forKey: .schema)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.schema, forKey: .schema)
        try container.encodeIfPresent(self.description, forKey: .description)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case schema
        case description
    }
}