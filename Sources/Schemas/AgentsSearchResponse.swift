import Foundation

public struct AgentsSearchResponse: Codable, Hashable, Sendable {
    /// The page being returned, starts at 0
    public let number: Int
    /// The number of elements in this page
    public let size: Int
    /// The total number of elements in the collection
    public let totalElements: Int64
    /// The total number of pages in the collection
    public let totalPages: Int
    public let agents: [Agent]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        number: Int,
        size: Int,
        totalElements: Int64,
        totalPages: Int,
        agents: [Agent],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.number = number
        self.size = size
        self.totalElements = totalElements
        self.totalPages = totalPages
        self.agents = agents
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.size = try container.decode(Int.self, forKey: .size)
        self.totalElements = try container.decode(Int64.self, forKey: .totalElements)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.agents = try container.decode([Agent].self, forKey: .agents)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.number, forKey: .number)
        try container.encode(self.size, forKey: .size)
        try container.encode(self.totalElements, forKey: .totalElements)
        try container.encode(self.totalPages, forKey: .totalPages)
        try container.encode(self.agents, forKey: .agents)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case number
        case size
        case totalElements
        case totalPages
        case agents
    }
}