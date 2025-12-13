import Foundation

public final class InboxClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Retrieve a paginated list of inbox items for an agent.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: InboxSearchRequest, requestOptions: RequestOptions? = nil) async throws -> InboxSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/inbox/search",
            body: request,
            requestOptions: requestOptions,
            responseType: InboxSearchResponse.self
        )
    }

    /// Retrieve details of a specific inbox item by its ID.
    ///
    /// - Parameter inboxItemId: The ID of the inbox item to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the inbox item to retrieve
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(inboxItemId: String, appId: String, requestOptions: RequestOptions? = nil) async throws -> InboxItem {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/inbox/\(inboxItemId)",
            queryParams: [
                "appId": .string(appId)
            ],
            requestOptions: requestOptions,
            responseType: InboxItem.self
        )
    }

    /// Retrieve a suggested fix. Includes document information if the fix is a Missing Knowledge suggestion.
    ///
    /// - Parameter inboxItemFixId: Unique identifier for the inbox fix.
    /// - Parameter appId: The App ID of the inbox item fix to retrieve
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getFix(inboxItemFixId: String, appId: String, requestOptions: RequestOptions? = nil) async throws -> InboxItemFix {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/inbox/fix/\(inboxItemFixId)",
            queryParams: [
                "appId": .string(appId)
            ],
            requestOptions: requestOptions,
            responseType: InboxItemFix.self
        )
    }

    /// Apply a list of fixes belonging to an inbox item.
    ///
    /// - Parameter inboxItemId: Unique identifier for the inbox item.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func applyFixes(inboxItemId: String, request: ApplyFixesRequest, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/inbox/\(inboxItemId)/applyfixes",
            body: request,
            requestOptions: requestOptions
        )
    }

    /// Ignore a specific inbox item by its ID.
    ///
    /// - Parameter inboxItemId: Unique identifier for the inbox item.
    /// - Parameter appId: The App ID of the inbox item fix to ignore
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func ignore(inboxItemId: String, appId: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/inbox/\(inboxItemId)/ignore",
            queryParams: [
                "appId": .string(appId)
            ],
            requestOptions: requestOptions
        )
    }
}