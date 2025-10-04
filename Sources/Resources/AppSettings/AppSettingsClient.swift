import Foundation

public final class AppSettingsClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Search for app settings which have the `$index` key set to the provided value.
    /// 
    /// You can set the `$index` key using the Update app settings API.
    /// 
    /// <Warning>This API currently requires an organization ID and agent ID for any agent which is installed on the app. This requirement will be removed in a future update.</Warning>
    ///
    /// - Parameter index: Will return all settings which have the `$index` key set to the provided value.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(index: String, requestOptions: RequestOptions? = nil) async throws -> SearchAppSettingsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/app-settings/search",
            queryParams: [
                "index": .string(index)
            ],
            requestOptions: requestOptions,
            responseType: SearchAppSettingsResponse.self
        )
    }

    /// Get app settings set during installation
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/app-settings",
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// Update app settings. Performs a merge of the provided settings with the existing app settings.
    /// 
    /// - If a new key is provided, it will be added to the app settings.
    /// - If an existing key is provided, it will be updated.
    /// - No keys will be removed.
    /// 
    /// Note that if an array value is provided it will fully replace an existing value as arrays cannot be merged.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func update(request: [String: JSONValue], requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/app-settings",
            body: request,
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }
}