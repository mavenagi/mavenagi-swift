import Foundation

public struct ResponseConfigPrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    public let useMarkdown: Bool?
    public let useForms: Bool?
    public let useImages: Bool?
    public let isCopilot: Bool?
    public let responseLength: ResponseLength?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        useMarkdown: Bool? = nil,
        useForms: Bool? = nil,
        useImages: Bool? = nil,
        isCopilot: Bool? = nil,
        responseLength: ResponseLength? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.useMarkdown = useMarkdown
        self.useForms = useForms
        self.useImages = useImages
        self.isCopilot = isCopilot
        self.responseLength = responseLength
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.useMarkdown = try container.decodeIfPresent(Bool.self, forKey: .useMarkdown)
        self.useForms = try container.decodeIfPresent(Bool.self, forKey: .useForms)
        self.useImages = try container.decodeIfPresent(Bool.self, forKey: .useImages)
        self.isCopilot = try container.decodeIfPresent(Bool.self, forKey: .isCopilot)
        self.responseLength = try container.decodeIfPresent(ResponseLength.self, forKey: .responseLength)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encodeIfPresent(self.useMarkdown, forKey: .useMarkdown)
        try container.encodeIfPresent(self.useForms, forKey: .useForms)
        try container.encodeIfPresent(self.useImages, forKey: .useImages)
        try container.encodeIfPresent(self.isCopilot, forKey: .isCopilot)
        try container.encodeIfPresent(self.responseLength, forKey: .responseLength)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case useMarkdown
        case useForms
        case useImages
        case isCopilot
        case responseLength
    }
}