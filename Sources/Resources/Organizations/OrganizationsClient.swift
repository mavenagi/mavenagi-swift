import Foundation

public final class OrganizationsClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create a new organization.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter organizationReferenceId: The reference ID of the organization.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func create(organizationReferenceId: String, request: CreateOrganizationRequest, requestOptions: RequestOptions? = nil) async throws -> Organization {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/organizations/\(organizationReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: Organization.self
        )
    }

    /// Get an organization by ID
    ///
    /// - Parameter organizationReferenceId: The reference ID of the organization.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(organizationReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> Organization {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/organizations/\(organizationReferenceId)",
            requestOptions: requestOptions,
            responseType: Organization.self
        )
    }

    /// Update mutable organization fields.
    /// All fields will overwrite the existing value on the organization only if provided.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter organizationReferenceId: The reference ID of the organization.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(organizationReferenceId: String, request: OrganizationPatchRequest, requestOptions: RequestOptions? = nil) async throws -> Organization {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/organizations/\(organizationReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: Organization.self
        )
    }

    /// Delete an organization.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter organizationReferenceId: The reference ID of the organization.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(organizationReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/organizations/\(organizationReferenceId)",
            requestOptions: requestOptions
        )
    }

    /// Retrieves structured conversation data across all organizations, formatted as a table, 
    /// allowing users to group, filter, and define specific metrics to display as columns.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getConversationTable(request: ConversationTableRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationTableResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/organizations/tables/conversations",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationTableResponse.self
        )
    }

    /// Fetches conversation data across all organizations, visualized in a chart format. 
    /// Supported chart types include pie chart, date histogram, and stacked bar charts.
    /// 
    /// <Tip>
    /// This endpoint requires additional permissions. Contact support to request access.
    /// </Tip>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getConversationChart(request: ConversationChartRequest, requestOptions: RequestOptions? = nil) async throws -> ChartResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/organizations/charts/conversations",
            body: request,
            requestOptions: requestOptions,
            responseType: ChartResponse.self
        )
    }
}