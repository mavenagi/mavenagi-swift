import Foundation

public struct DeliverMessageResponse: Codable, Hashable, Sendable {
    public let status: DeliveryStatus
    /// The conversation the message was delivered to, or attempted on when `status` is `FAILED`. Absent when
    /// no conversation qualified for a delivery to a user.
    public let conversationId: EntityId?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        status: DeliveryStatus,
        conversationId: EntityId? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.status = status
        self.conversationId = conversationId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(DeliveryStatus.self, forKey: .status)
        self.conversationId = try container.decodeIfPresent(EntityId.self, forKey: .conversationId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.conversationId, forKey: .conversationId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case status
        case conversationId
    }
}