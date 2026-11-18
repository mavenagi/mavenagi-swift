import Foundation

/// What a trigger is simulated with. Only `EVENT_CREATED` triggers can be simulated; any other
/// trigger type is rejected with a 400.
public struct TriggerSimulationInput: Codable, Hashable, Sendable {
    /// The event the trigger fires for, in the shape creating an event takes, and checked as
    /// creating it would be. It is sent to the trigger as a `SIMULATION` event and never stored.
    /// An `executionMode` of `LIVE` is rejected with a 400. The trigger's condition is not
    /// evaluated: the event is sent to it even when a live event like it would not match.
    public let event: EventRequest
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        event: EventRequest,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.event = event
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.event = try container.decode(EventRequest.self, forKey: .event)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.event, forKey: .event)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case event
    }
}