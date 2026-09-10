import Foundation

public final class AppDirectoryClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Lists apps available to install on the agent, with filtering and pagination.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: DirectoryAppsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> AppsResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/directory/search",
            body: request,
            requestOptions: requestOptions,
            responseType: AppsResponse.self
        )
    }

    /// Gets an app and its installation status for the agent.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(appId: String, requestOptions: RequestOptions? = nil) async throws -> MarketplaceAppDetail {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/directory/\(appId)",
            requestOptions: requestOptions,
            responseType: MarketplaceAppDetail.self
        )
    }

    /// Installs the app on the agent, or updates settings for an existing installation. Re-runs the postInstall lifecycle hook on each call.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func install(appId: String, request: InstallDirectoryAppRequest, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/directory/\(appId)/install",
            body: request,
            requestOptions: requestOptions
        )
    }

    /// Uninstalls the app from the agent.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func uninstall(appId: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/directory/\(appId)/install",
            requestOptions: requestOptions
        )
    }

    /// Gets a url for downloading a file app setting.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getSettingDownloadUrl(appId: String, settingsKey: String, requestOptions: RequestOptions? = nil) async throws -> GetDirectoryAppSettingDownloadUrlResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/directory/\(appId)/settings/\(settingsKey)",
            requestOptions: requestOptions,
            responseType: GetDirectoryAppSettingDownloadUrlResponse.self
        )
    }

    /// Gets a presigned url for uploading a file app setting before installation.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getSettingUploadUrl(appId: String, settingsKey: String, request: Requests.GetAppSettingUploadUrlRequest, requestOptions: RequestOptions? = nil) async throws -> GetDirectoryAppSettingUploadUrlResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/directory/\(appId)/settings/\(settingsKey)/upload-url",
            body: request,
            requestOptions: requestOptions,
            responseType: GetDirectoryAppSettingUploadUrlResponse.self
        )
    }
}