import Foundation

public final class IntegrationsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Update an integration.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func update(organizationId: String, integrationId: String, request: UpdateIntegrationRequest, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/organizations/\(organizationId)/integrations/\(integrationId)",
            body: request,
            requestOptions: requestOptions
        )
    }
}