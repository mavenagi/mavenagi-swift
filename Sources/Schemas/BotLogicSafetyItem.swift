import Foundation

public struct BotLogicSafetyItem: Codable, Hashable, Sendable {
    public let safetyCheckPassed: Bool
    /// If the safety check failed, this contains more details about the failure.
    public let report: SafetyCheckReport?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        safetyCheckPassed: Bool,
        report: SafetyCheckReport? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.safetyCheckPassed = safetyCheckPassed
        self.report = report
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.safetyCheckPassed = try container.decode(Bool.self, forKey: .safetyCheckPassed)
        self.report = try container.decodeIfPresent(SafetyCheckReport.self, forKey: .report)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.safetyCheckPassed, forKey: .safetyCheckPassed)
        try container.encodeIfPresent(self.report, forKey: .report)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case safetyCheckPassed
        case report
    }
}