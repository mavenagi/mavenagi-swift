import Foundation

public struct InstallDirectoryAppRequest: Codable, Hashable, Sendable {
    /// The app's configuration, as an object keyed by setting key.
    /// 
    /// The keys and accepted values are defined by the app itself: fetch the app with
    /// `get` and read its `settingsSchema`, where every entry carries a `key`, a `type`, and
    /// whether it is `required`. Values are merged into the installation's existing settings:
    /// keys you omit keep their stored value, and the server does not currently reject an unknown
    /// key or require an entry the schema marks `required`. Sending an empty object installs an
    /// app that declares no settings.
    /// 
    /// Sensitive entries are returned redacted by `get`, and sending one back unchanged here is a
    /// no-op that keeps the stored value, so a settings object can be read, edited and written
    /// back whole. See `MarketplaceAppDetail.settings` for what is redacted and how.
    /// 
    /// The value's JSON type follows the entry's `type`:
    /// 
    /// | Entry type | Value |
    /// | --- | --- |
    /// | `text`, `multiline`, `color`, `dropdown` | string |
    /// | `number` | number |
    /// | `checkbox`, `switch` | boolean |
    /// | `array` | list of strings |
    /// | `complexarray` | list of objects |
    /// | `oneOf`, `jsonSchema` | object matching the entry's schema |
    /// | `image` | omitted — see below |
    /// 
    /// `image` entries are file settings. Do not send their bytes here: upload them first with
    /// `getSettingUploadUrl` using the same setting key, and the stored file is picked up
    /// automatically. `section` entries are layout only and take no value.
    /// 
    /// ```json
    /// {
    ///   "settings": {
    ///     "acme.api.key": "sk-live-...",
    ///     "acme.region": "us-east-1",
    ///     "acme.sync.enabled": true,
    ///     "acme.retry.count": 3
    ///   }
    /// }
    /// ```
    public let settings: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        settings: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.settings = settings
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.settings = try container.decode(JSONValue.self, forKey: .settings)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.settings, forKey: .settings)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case settings
    }
}