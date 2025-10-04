import Foundation

public enum InboxItemFix: Codable, Hashable, Sendable {
    case addDocument(AddDocument)
    case deactivateDocument(DeactivateDocument)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "addDocument":
            self = .addDocument(try AddDocument(from: decoder))
        case "deactivateDocument":
            self = .deactivateDocument(try DeactivateDocument(from: decoder))
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
        case .addDocument(let data):
            try data.encode(to: encoder)
        case .deactivateDocument(let data):
            try data.encode(to: encoder)
        }
    }

    public struct AddDocument: Codable, Hashable, Sendable {
        public let type: String = "addDocument"
        /// Unique identifier for the inbox item fix.
        public let id: EntityId
        /// Suggested document title if the fix type is ADD_DOCUMENT.
        public let suggestedTextTitle: String
        /// Suggested document text if the fix type is ADD_DOCUMENT.
        public let suggestedText: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            id: EntityId,
            suggestedTextTitle: String,
            suggestedText: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.id = id
            self.suggestedTextTitle = suggestedTextTitle
            self.suggestedText = suggestedText
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.suggestedTextTitle = try container.decode(String.self, forKey: .suggestedTextTitle)
            self.suggestedText = try container.decode(String.self, forKey: .suggestedText)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.suggestedTextTitle, forKey: .suggestedTextTitle)
            try container.encode(self.suggestedText, forKey: .suggestedText)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case id
            case suggestedTextTitle
            case suggestedText
        }
    }

    public struct DeactivateDocument: Codable, Hashable, Sendable {
        public let type: String = "deactivateDocument"
        /// Unique identifier for the inbox item fix.
        public let id: EntityId
        /// Information about the document associated with this fix.
        public let documentInformation: DocumentInformation
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            id: EntityId,
            documentInformation: DocumentInformation,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.id = id
            self.documentInformation = documentInformation
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.documentInformation = try container.decode(DocumentInformation.self, forKey: .documentInformation)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.documentInformation, forKey: .documentInformation)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case id
            case documentInformation
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}