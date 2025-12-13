import Foundation

public final class UsersClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Search across all agent users on an agent.
    /// 
    /// Agent users are a merged view of the users created by individual apps.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: AgentUserSearchRequest, requestOptions: RequestOptions? = nil) async throws -> AgentUserSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/agentusers/search",
            body: request,
            requestOptions: requestOptions,
            responseType: AgentUserSearchResponse.self
        )
    }

    /// Get an agent user by its supplied ID.
    /// 
    /// Agent users are a merged view of the users created by individual apps.
    ///
    /// - Parameter agentUserId: The ID of the agent user to get.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getAgentUser(agentUserId: String, requestOptions: RequestOptions? = nil) async throws -> AgentUser {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/agentusers/\(agentUserId)",
            requestOptions: requestOptions,
            responseType: AgentUser.self
        )
    }

    /// Update an app user or create it if it doesn't exist.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: AppUserRequest, requestOptions: RequestOptions? = nil) async throws -> AppUserResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/users",
            body: request,
            requestOptions: requestOptions,
            responseType: AppUserResponse.self
        )
    }

    /// Get an app user by its supplied ID
    ///
    /// - Parameter userId: The reference ID of the app user to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the app user to get. If not provided the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(userId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> AppUserResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/users/\(userId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: AppUserResponse.self
        )
    }

    /// Deletes all identifiers and user data saved by the specified app.
    /// Does not modify data or identifiers saved by other apps.
    /// 
    /// If this user is linked to a user from another app, it will not be unlinked. Unlinking of users is not yet supported.
    /// 
    /// <Warning>This is a destructive operation and cannot be undone.</Warning>
    ///
    /// - Parameter userId: The reference ID of the app user to delete. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the app user to delete. If not provided the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(userId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/users/\(userId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions
        )
    }
}