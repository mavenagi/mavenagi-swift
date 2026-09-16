import Foundation

public enum KnowledgeContextFilter: Codable, Hashable, Sendable {
    case byEntities(ByEntities)
    /// Not yet supported. This variant is accepted but has no effect on retrieval - a
    /// conversation supplying it behaves as though no `contextFilter` were provided at all.
    /// Use `byEntities` to scope retrieval today.
    case byEntityTypes(ByEntityTypes)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .scopeType)
        switch discriminant {
        case "byEntities":
            self = .byEntities(try ByEntities(from: decoder))
        case "byEntityTypes":
            self = .byEntityTypes(try ByEntityTypes(from: decoder))
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
        case .byEntities(let data):
            try data.encode(to: encoder)
        case .byEntityTypes(let data):
            try data.encode(to: encoder)
        }
    }

    public struct ByEntities: Codable, Hashable, Sendable {
        public let scopeType: String = "byEntities"
        /// The entities whose documents should be retrievable, in addition to the agent's own
        /// knowledge. Each `entityId` must be fully specified and must belong to the organization
        /// and agent the request is made against; one that does not is rejected. Entities are never
        /// silently dropped, which would omit exactly the documents the caller asked to bring into
        /// scope.
        /// 
        /// `AGENT` and `FEEDBACK` are rejected: neither has an internal form to resolve to, and
        /// `AGENT` in particular is redundant here because the agent's own knowledge is always in
        /// scope. Every other `EntityType` is accepted.
        public let entities: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            entities: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.entities = entities
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.entities = try container.decode(JSONValue.self, forKey: .entities)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.scopeType, forKey: .scopeType)
            try container.encode(self.entities, forKey: .entities)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case scopeType
            case entities
        }
    }

    /// Not yet supported. This variant is accepted but has no effect on retrieval - a
    /// conversation supplying it behaves as though no `contextFilter` were provided at all.
    /// Use `byEntities` to scope retrieval today.
    public struct ByEntityTypes: Codable, Hashable, Sendable {
        public let scopeType: String = "byEntityTypes"
        public let entityTypes: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            entityTypes: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.entityTypes = entityTypes
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.entityTypes = try container.decode(JSONValue.self, forKey: .entityTypes)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.scopeType, forKey: .scopeType)
            try container.encode(self.entityTypes, forKey: .entityTypes)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case scopeType
            case entityTypes
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case scopeType
    }
}