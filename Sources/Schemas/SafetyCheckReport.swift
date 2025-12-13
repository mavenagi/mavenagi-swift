import Foundation

public struct SafetyCheckReport: Codable, Hashable, Sendable {
    /// Whether the check detected a malicious attack.
    public let attackDetected: Bool
    /// Whether the check detected harmful content such as hate speech, references to self-harm, violence or sexual references.
    public let harmfulContentDetected: Bool
    /// Includes details on each category of harmful content.
    public let harmfulContentAnalysis: [HarmfulContentAnalysis]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        attackDetected: Bool,
        harmfulContentDetected: Bool,
        harmfulContentAnalysis: [HarmfulContentAnalysis],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.attackDetected = attackDetected
        self.harmfulContentDetected = harmfulContentDetected
        self.harmfulContentAnalysis = harmfulContentAnalysis
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attackDetected = try container.decode(Bool.self, forKey: .attackDetected)
        self.harmfulContentDetected = try container.decode(Bool.self, forKey: .harmfulContentDetected)
        self.harmfulContentAnalysis = try container.decode([HarmfulContentAnalysis].self, forKey: .harmfulContentAnalysis)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.attackDetected, forKey: .attackDetected)
        try container.encode(self.harmfulContentDetected, forKey: .harmfulContentDetected)
        try container.encode(self.harmfulContentAnalysis, forKey: .harmfulContentAnalysis)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case attackDetected
        case harmfulContentDetected
        case harmfulContentAnalysis
    }
}