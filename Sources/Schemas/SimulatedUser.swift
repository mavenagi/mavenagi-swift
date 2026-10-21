import Foundation

/// A user described in full by the caller, for one run only. Nothing is looked up or stored,
/// so no agent user has to exist first.
public struct SimulatedUser: Codable, Hashable, Sendable {
    /// The user's data, keyed by field name, with that field's value from each app that set it.
    public let agentUserData: [String: [SimulatedUserData]]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        agentUserData: [String: [SimulatedUserData]]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.agentUserData = agentUserData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.agentUserData = try container.decodeIfPresent([String: [SimulatedUserData]].self, forKey: .agentUserData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.agentUserData, forKey: .agentUserData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case agentUserData
    }
}