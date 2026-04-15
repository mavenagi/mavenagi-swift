import Foundation

public struct SegmentResponse: Codable, Hashable, Sendable {
    /// The name of the segment.
    public let name: String
    /// A plain text description of the segment.
    public let description: String?
    /// ID that uniquely identifies this segment
    public let segmentId: EntityId
    /// The precondition that must be met for a conversation message to be included in the segment.
    public let precondition: PreconditionResponse
    /// The date and time when the segment was created.
    public let createdAt: Date
    /// The date and time when the segment was last updated.
    public let updatedAt: Date
    /// The number of active knowledge bases that reference this segment.
    public let referencedKnowledgeBaseCount: Int64?
    /// The number of active documents that reference this segment.
    public let referencedDocumentCount: Int64?
    /// The number of active actions that reference this segment.
    public let referencedActionCount: Int64?
    /// The status of the segment.
    /// 
    /// - ACTIVE: Segment is in use and will be evaluated for matching user questions.
    /// - INACTIVE: Segment is not in use but can be reactivated.
    /// - DELETED: Segment has been soft deleted. Excluded from searches and cannot be modified.
    public let status: SegmentStatus
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String? = nil,
        segmentId: EntityId,
        precondition: PreconditionResponse,
        createdAt: Date,
        updatedAt: Date,
        referencedKnowledgeBaseCount: Int64? = nil,
        referencedDocumentCount: Int64? = nil,
        referencedActionCount: Int64? = nil,
        status: SegmentStatus,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.segmentId = segmentId
        self.precondition = precondition
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.referencedKnowledgeBaseCount = referencedKnowledgeBaseCount
        self.referencedDocumentCount = referencedDocumentCount
        self.referencedActionCount = referencedActionCount
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.segmentId = try container.decode(EntityId.self, forKey: .segmentId)
        self.precondition = try container.decode(PreconditionResponse.self, forKey: .precondition)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.referencedKnowledgeBaseCount = try container.decodeIfPresent(Int64.self, forKey: .referencedKnowledgeBaseCount)
        self.referencedDocumentCount = try container.decodeIfPresent(Int64.self, forKey: .referencedDocumentCount)
        self.referencedActionCount = try container.decodeIfPresent(Int64.self, forKey: .referencedActionCount)
        self.status = try container.decode(SegmentStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.segmentId, forKey: .segmentId)
        try container.encode(self.precondition, forKey: .precondition)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(self.referencedKnowledgeBaseCount, forKey: .referencedKnowledgeBaseCount)
        try container.encodeIfPresent(self.referencedDocumentCount, forKey: .referencedDocumentCount)
        try container.encodeIfPresent(self.referencedActionCount, forKey: .referencedActionCount)
        try container.encode(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case segmentId
        case precondition
        case createdAt
        case updatedAt
        case referencedKnowledgeBaseCount
        case referencedDocumentCount
        case referencedActionCount
        case status
    }
}