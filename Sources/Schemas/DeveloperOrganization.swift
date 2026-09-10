import Foundation

/// The public profile of an organization that authors apps, shown for attribution and support.
public struct DeveloperOrganization: Codable, Hashable, Sendable {
    /// Id of the authoring organization.
    public let organizationId: String
    /// Display name of the authoring organization.
    public let name: String
    /// Public website for the organization.
    public let website: String?
    /// Contact email published by the organization.
    public let email: String?
    /// Contact phone number published by the organization.
    public let phone: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        organizationId: String,
        name: String,
        website: String? = nil,
        email: String? = nil,
        phone: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.organizationId = organizationId
        self.name = name
        self.website = website
        self.email = email
        self.phone = phone
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.organizationId = try container.decode(String.self, forKey: .organizationId)
        self.name = try container.decode(String.self, forKey: .name)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.organizationId, forKey: .organizationId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.website, forKey: .website)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.phone, forKey: .phone)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case organizationId
        case name
        case website
        case email
        case phone
    }
}