import Foundation

/// What a trigger's run has beyond the fields every run has.
public struct TriggerRunDetails: Codable, Hashable, Sendable {
    /// The kind of event that caused this run.
    public let eventType: EventTriggerType
    /// How a failure should be treated. Present only on FAILED executions.
    public let retryability: CapabilityExecutionRetryability?
    /// HTTP status returned by the app, when the failure carried one.
    public let httpStatus: Int?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventType: EventTriggerType,
        retryability: CapabilityExecutionRetryability? = nil,
        httpStatus: Int? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventType = eventType
        self.retryability = retryability
        self.httpStatus = httpStatus
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventType = try container.decode(EventTriggerType.self, forKey: .eventType)
        self.retryability = try container.decodeIfPresent(CapabilityExecutionRetryability.self, forKey: .retryability)
        self.httpStatus = try container.decodeIfPresent(Int.self, forKey: .httpStatus)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventType, forKey: .eventType)
        try container.encodeIfPresent(self.retryability, forKey: .retryability)
        try container.encodeIfPresent(self.httpStatus, forKey: .httpStatus)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventType
        case retryability
        case httpStatus
    }
}