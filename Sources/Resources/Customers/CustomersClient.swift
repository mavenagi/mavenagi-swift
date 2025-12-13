import Foundation

public final class CustomersClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    public func search(request: CustomersSearchRequest, requestOptions: RequestOptions? = nil) async throws -> CustomersSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/customers",
            body: request,
            requestOptions: requestOptions,
            responseType: CustomersSearchResponse.self
        )
    }

    /// Update a customer of an agent or create it if it doesn't exist. In case of an update, fields not provided (e.g., description, status) will be preserved.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: CustomerRequest, requestOptions: RequestOptions? = nil) async throws -> CustomerResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/customers",
            body: request,
            requestOptions: requestOptions,
            responseType: CustomerResponse.self
        )
    }

    /// Get a customer by its supplied ID
    ///
    /// - Parameter customerReferenceId: The reference ID of the customer to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the customer to get. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(customerReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> CustomerResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/customers/\(customerReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: CustomerResponse.self
        )
    }

    /// Update mutable customer fields
    /// 
    /// The `appId` field can be provided to update a customer owned by a different app.
    /// All other fields will overwrite the existing value on the customer only if provided.
    ///
    /// - Parameter customerReferenceId: The reference ID of the customer to update. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(customerReferenceId: String, request: CustomerPatchRequest, requestOptions: RequestOptions? = nil) async throws -> CustomerResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/customers/\(customerReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: CustomerResponse.self
        )
    }
}