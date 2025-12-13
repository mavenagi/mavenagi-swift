import Foundation

public struct HarmfulContentAnalysis: Codable, Hashable, Sendable {
    /// The category of harmful content analysis.
    public let category: String
    /// Whether the analysis detected harmful content for this category. Will be true if the severity is greater than or equal to the threshold.
    public let harmfulContentDetected: Bool
    /// The severity of the harmful content analysis. Will be 0 if the category was not detected.
    public let severity: Int
    /// The threshold for the content safety analysis. If the severity is greater than or equal to the threshold, the analysis will be considered harmful.
    public let threshold: Int
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        category: String,
        harmfulContentDetected: Bool,
        severity: Int,
        threshold: Int,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.category = category
        self.harmfulContentDetected = harmfulContentDetected
        self.severity = severity
        self.threshold = threshold
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try container.decode(String.self, forKey: .category)
        self.harmfulContentDetected = try container.decode(Bool.self, forKey: .harmfulContentDetected)
        self.severity = try container.decode(Int.self, forKey: .severity)
        self.threshold = try container.decode(Int.self, forKey: .threshold)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.harmfulContentDetected, forKey: .harmfulContentDetected)
        try container.encode(self.severity, forKey: .severity)
        try container.encode(self.threshold, forKey: .threshold)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case category
        case harmfulContentDetected
        case severity
        case threshold
    }
}