import Foundation

/// The structured answer for an ask whose `textFormat` was `jsonSchema`, emitted once and already complete. There is nothing to concatenate, and no partial object is ever sent.
/// It arrives late in the stream — the object is only known once the whole answer parses — and alongside the `text` events carrying the prose answer, not instead of them.
public struct AskStreamObjectEvent: Codable, Hashable, Sendable {
    /// The answer, matching the schema the ask supplied. Every property the schema requires is present, with `null` where a nullable one does not apply.
    public let object: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        object: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.object = object
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.object = try container.decode(JSONValue.self, forKey: .object)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.object, forKey: .object)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case object
    }
}