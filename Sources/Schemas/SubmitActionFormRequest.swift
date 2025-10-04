import Foundation

public struct SubmitActionFormRequest: Codable, Hashable, Sendable {
    public let actionFormId: String
    /// Map of parameter IDs to values provided by the user. All required action fields must be provided.
    public let parameters: [String: ActionFormRequestParamValue]
    /// Transient data which the Maven platform will not persist. This data will only be forwarded to actions taken. For example, one may put in user tokens as transient data.
    public let transientData: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionFormId: String,
        parameters: [String: ActionFormRequestParamValue],
        transientData: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionFormId = actionFormId
        self.parameters = parameters
        self.transientData = transientData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionFormId = try container.decode(String.self, forKey: .actionFormId)
        self.parameters = try container.decode([String: ActionFormRequestParamValue].self, forKey: .parameters)
        self.transientData = try container.decodeIfPresent([String: String].self, forKey: .transientData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionFormId, forKey: .actionFormId)
        try container.encode(self.parameters, forKey: .parameters)
        try container.encodeIfPresent(self.transientData, forKey: .transientData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionFormId
        case parameters
        case transientData
    }
}