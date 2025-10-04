import Foundation

public final class AgentCapabilitiesClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// List all capabilities for an agent.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(request: AgentCapabilityListRequest, requestOptions: RequestOptions? = nil) async throws -> ListAgentCapabilitiesResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/capabilities",
            body: request,
            requestOptions: requestOptions,
            responseType: ListAgentCapabilitiesResponse.self
        )
    }

    public func get(integrationId: String, capabilityId: String, requestOptions: RequestOptions? = nil) async throws -> AgentCapability {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/integrations/\(integrationId)/capabilities/\(capabilityId)",
            requestOptions: requestOptions,
            responseType: AgentCapability.self
        )
    }

    public func patch(integrationId: String, capabilityId: String, request: PatchAgentCapabilityRequest, requestOptions: RequestOptions? = nil) async throws -> AgentCapability {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/integrations/\(integrationId)/capabilities/\(capabilityId)",
            body: request,
            requestOptions: requestOptions,
            responseType: AgentCapability.self
        )
    }

    /// Execute an action capability.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func execute(integrationId: String, capabilityId: String, request: ExecuteCapabilityRequest, requestOptions: RequestOptions? = nil) async throws -> ExecuteCapabilityResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/integrations/\(integrationId)/capabilities/\(capabilityId)/execute",
            body: request,
            requestOptions: requestOptions,
            responseType: ExecuteCapabilityResponse.self
        )
    }
}