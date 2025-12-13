import Foundation

public final class ActionsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    public func search(request: ActionsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> ActionsResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/actions/search",
            body: request,
            requestOptions: requestOptions,
            responseType: ActionsResponse.self
        )
    }

    /// Update an action or create it if it doesn't exist
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: ActionRequest, requestOptions: RequestOptions? = nil) async throws -> ActionResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/actions",
            body: request,
            requestOptions: requestOptions,
            responseType: ActionResponse.self
        )
    }

    /// Get an action by its supplied ID
    ///
    /// - Parameter actionReferenceId: The reference ID of the action to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the action to get. If not provided the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(actionReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> ActionResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/actions/\(actionReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: ActionResponse.self
        )
    }

    /// Update mutable action fields
    /// 
    /// The `appId` field can be provided to update an action owned by a different app. 
    /// All other fields will overwrite the existing value on the action only if provided.
    ///
    /// - Parameter actionReferenceId: The reference ID of the action to patch.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(actionReferenceId: String, request: Requests.ActionPatchRequest, requestOptions: RequestOptions? = nil) async throws -> ActionResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/actions/\(actionReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: ActionResponse.self
        )
    }

    /// Delete an action
    ///
    /// - Parameter actionReferenceId: The reference ID of the action to unregister. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(actionReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/actions/\(actionReferenceId)",
            requestOptions: requestOptions
        )
    }
}