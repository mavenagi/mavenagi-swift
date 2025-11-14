import Foundation

public enum InboxItem: Codable, Hashable, Sendable {
    case duplicateDocuments(DuplicateDocuments)
    case missingKnowledge(MissingKnowledge)
    case custom(Custom)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "duplicateDocuments":
            self = .duplicateDocuments(try DuplicateDocuments(from: decoder))
        case "missingKnowledge":
            self = .missingKnowledge(try MissingKnowledge(from: decoder))
        case "custom":
            self = .custom(try Custom(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .duplicateDocuments(let data):
            try data.encode(to: encoder)
        case .missingKnowledge(let data):
            try data.encode(to: encoder)
        case .custom(let data):
            try data.encode(to: encoder)
        }
    }

    public struct DuplicateDocuments: Codable, Hashable, Sendable {
        public let type: String = "duplicateDocuments"
        /// Unique identifier for the inbox item.
        public let id: EntityId
        /// Timestamp when the inbox item was created.
        public let createdAt: Date
        /// Timestamp when the inbox item was last updated.
        public let updatedAt: Date
        /// Status of the inbox item.
        public let status: InboxItemStatus
        /// Severity of the inbox item.
        public let severity: InboxItemSeverity
        /// The fix recommended for being applied
        public let recommendedFixes: [InboxItemFixDeactivateDocument]
        /// List of fixes associated with the inbox item.
        public let otherFixes: [InboxItemFixDeactivateDocument]
        /// Information about the source document associated with the inbox item.
        public let sourceDocument: DocumentInformation
        /// List of Document information objects related to the inbox item.
        public let documents: [DocumentInformation]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            id: EntityId,
            createdAt: Date,
            updatedAt: Date,
            status: InboxItemStatus,
            severity: InboxItemSeverity,
            recommendedFixes: [InboxItemFixDeactivateDocument],
            otherFixes: [InboxItemFixDeactivateDocument],
            sourceDocument: DocumentInformation,
            documents: [DocumentInformation],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.severity = severity
            self.recommendedFixes = recommendedFixes
            self.otherFixes = otherFixes
            self.sourceDocument = sourceDocument
            self.documents = documents
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(InboxItemStatus.self, forKey: .status)
            self.severity = try container.decode(InboxItemSeverity.self, forKey: .severity)
            self.recommendedFixes = try container.decode([InboxItemFixDeactivateDocument].self, forKey: .recommendedFixes)
            self.otherFixes = try container.decode([InboxItemFixDeactivateDocument].self, forKey: .otherFixes)
            self.sourceDocument = try container.decode(DocumentInformation.self, forKey: .sourceDocument)
            self.documents = try container.decode([DocumentInformation].self, forKey: .documents)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.severity, forKey: .severity)
            try container.encode(self.recommendedFixes, forKey: .recommendedFixes)
            try container.encode(self.otherFixes, forKey: .otherFixes)
            try container.encode(self.sourceDocument, forKey: .sourceDocument)
            try container.encode(self.documents, forKey: .documents)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case id
            case createdAt
            case updatedAt
            case status
            case severity
            case recommendedFixes
            case otherFixes
            case sourceDocument
            case documents
        }
    }

    public struct MissingKnowledge: Codable, Hashable, Sendable {
        public let type: String = "missingKnowledge"
        /// Unique identifier for the inbox item.
        public let id: EntityId
        /// Timestamp when the inbox item was created.
        public let createdAt: Date
        /// Timestamp when the inbox item was last updated.
        public let updatedAt: Date
        /// Status of the inbox item.
        public let status: InboxItemStatus
        /// Severity of the inbox item.
        public let severity: InboxItemSeverity
        /// Fix associated with the inbox item.
        public let fix: InboxItemFixAddDocument
        /// List of Conversation information objects related to the inbox item.
        public let conversations: [ConversationInformation]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            id: EntityId,
            createdAt: Date,
            updatedAt: Date,
            status: InboxItemStatus,
            severity: InboxItemSeverity,
            fix: InboxItemFixAddDocument,
            conversations: [ConversationInformation],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.severity = severity
            self.fix = fix
            self.conversations = conversations
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(InboxItemStatus.self, forKey: .status)
            self.severity = try container.decode(InboxItemSeverity.self, forKey: .severity)
            self.fix = try container.decode(InboxItemFixAddDocument.self, forKey: .fix)
            self.conversations = try container.decode([ConversationInformation].self, forKey: .conversations)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.severity, forKey: .severity)
            try container.encode(self.fix, forKey: .fix)
            try container.encode(self.conversations, forKey: .conversations)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case id
            case createdAt
            case updatedAt
            case status
            case severity
            case fix
            case conversations
        }
    }

    public struct Custom: Codable, Hashable, Sendable {
        public let type: String = "custom"
        /// Unique identifier for the inbox item.
        public let id: EntityId
        /// Timestamp when the inbox item was created.
        public let createdAt: Date
        /// Timestamp when the inbox item was last updated.
        public let updatedAt: Date
        /// Status of the inbox item.
        public let status: InboxItemStatus
        /// Severity of the inbox item.
        public let severity: InboxItemSeverity
        /// Additional metadata associated with the inbox item.
        public let metadata: [String: String]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            id: EntityId,
            createdAt: Date,
            updatedAt: Date,
            status: InboxItemStatus,
            severity: InboxItemSeverity,
            metadata: [String: String],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.severity = severity
            self.metadata = metadata
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(InboxItemStatus.self, forKey: .status)
            self.severity = try container.decode(InboxItemSeverity.self, forKey: .severity)
            self.metadata = try container.decode([String: String].self, forKey: .metadata)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.severity, forKey: .severity)
            try container.encode(self.metadata, forKey: .metadata)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case id
            case createdAt
            case updatedAt
            case status
            case severity
            case metadata
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}