import Foundation

public final class IntelligentFieldsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create a new intelligent field. Intelligent fields are used to store custom LLM-generated values on entities like conversations or events.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: IntelligentFieldRequest, requestOptions: RequestOptions? = nil) async throws -> IntelligentFieldResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/intelligent-fields",
            body: request,
            requestOptions: requestOptions,
            responseType: IntelligentFieldResponse.self
        )
    }

    /// Get an intelligent field by its supplied ID
    ///
    /// - Parameter fieldReferenceId: The reference ID of the intelligent field to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the intelligent field to get. If not provided the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(fieldReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> IntelligentFieldDetailResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/intelligent-fields/\(fieldReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: IntelligentFieldDetailResponse.self
        )
    }

    /// Patch an intelligent field. Can be used to update the definition, status, or other mutable properties.
    ///
    /// - Parameter fieldReferenceId: The reference ID of the intelligent field to patch.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(fieldReferenceId: String, request: Requests.IntelligentFieldPatchRequest, requestOptions: RequestOptions? = nil) async throws -> IntelligentFieldResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/intelligent-fields/\(fieldReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: IntelligentFieldResponse.self
        )
    }

    /// Soft delete an intelligent field. Only INACTIVE fields can be deleted.
    /// 
    /// Deleted fields are excluded from search results but can still be retrieved by ID.
    /// Creating a new field with the same referenceId as a deleted field will overwrite
    /// the deleted field and restore it to INACTIVE status.
    /// 
    /// Deleted fields cannot be modified.
    ///
    /// - Parameter fieldReferenceId: The reference ID of the intelligent field to delete.
    /// - Parameter appId: The App ID of the intelligent field to delete. If not provided, the ID of the calling app will be used.
    /// - Parameter variantReferenceId: The agent variant reference ID of the intelligent field to delete.
    /// - Parameter variantAppId: The App ID of the agent variant reference for the intelligent field to delete. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(fieldReferenceId: String, appId: String? = nil, variantReferenceId: String? = nil, variantAppId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> IntelligentFieldResponse {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/intelligent-fields/\(fieldReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "variantReferenceId": variantReferenceId.map { .string($0) }, 
                "variantAppId": variantAppId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: IntelligentFieldResponse.self
        )
    }

    /// Search computed values for intelligent fields across entities. Supports filtering by field properties and target entity.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func searchValues(request: IntelligentFieldValueSearchRequest, requestOptions: RequestOptions? = nil) async throws -> IntelligentFieldValueSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/intelligent-fields/values/search",
            body: request,
            requestOptions: requestOptions,
            responseType: IntelligentFieldValueSearchResponse.self
        )
    }
}