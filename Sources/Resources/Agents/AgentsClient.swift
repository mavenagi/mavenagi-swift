import Foundation

public final class AgentsClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Search for agents across all organizations.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: AgentsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> AgentsSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/agents",
            body: request,
            requestOptions: requestOptions,
            responseType: AgentsSearchResponse.self
        )
    }

    /// Lists all agents for an organization
    ///
    /// - Parameter organizationReferenceId: The ID of the organization.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(organizationReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> [Agent] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/organizations/\(organizationReferenceId)/agents",
            requestOptions: requestOptions,
            responseType: [Agent].self
        )
    }

    /// Create a new agent
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter organizationReferenceId: The ID of the organization.
    /// - Parameter agentReferenceId: The ID of the agent.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func create(organizationReferenceId: String, agentReferenceId: String, request: CreateAgentRequest, requestOptions: RequestOptions? = nil) async throws -> Agent {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/organizations/\(organizationReferenceId)/agents/\(agentReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: Agent.self
        )
    }

    /// Get an agent
    ///
    /// - Parameter organizationReferenceId: The ID of the organization.
    /// - Parameter agentReferenceId: The ID of the agent.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(organizationReferenceId: String, agentReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> Agent {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/organizations/\(organizationReferenceId)/agents/\(agentReferenceId)",
            requestOptions: requestOptions,
            responseType: Agent.self
        )
    }

    /// Update mutable agent fields 
    /// All fields will overwrite the existing value on the agent only if provided.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter organizationReferenceId: The ID of the organization.
    /// - Parameter agentReferenceId: The ID of the agent.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(organizationReferenceId: String, agentReferenceId: String, request: AgentPatchRequest, requestOptions: RequestOptions? = nil) async throws -> Agent {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/organizations/\(organizationReferenceId)/agents/\(agentReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: Agent.self
        )
    }

    /// Delete an agent.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter organizationReferenceId: The ID of the organization.
    /// - Parameter agentReferenceId: The ID of the agent.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(organizationReferenceId: String, agentReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/organizations/\(organizationReferenceId)/agents/\(agentReferenceId)",
            requestOptions: requestOptions
        )
    }
}