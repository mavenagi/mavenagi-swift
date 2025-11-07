import Foundation

public final class KnowledgeClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Search knowledge bases
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func searchKnowledgeBases(request: KnowledgeBaseSearchRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBasesResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/knowledge/search",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeBasesResponse.self
        )
    }

    /// Update a knowledge base or create it if it doesn't exist.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdateKnowledgeBase(request: KnowledgeBaseRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBaseResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/knowledge",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeBaseResponse.self
        )
    }

    /// Get an existing knowledge base by its supplied ID
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the knowledge base to get. If not provided the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getKnowledgeBase(knowledgeBaseReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBaseResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: KnowledgeBaseResponse.self
        )
    }

    /// Request that a knowledge base refresh itself.
    /// 
    /// Knowledge bases refresh on a schedule determined by the `refreshFrequency` field.
    /// They can also be refreshed on demand by calling this endpoint.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to refresh. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func refreshKnowledgeBase(knowledgeBaseReferenceId: String, request: KnowledgeBaseRefreshRequest, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/refresh",
            body: request,
            requestOptions: requestOptions
        )
    }

    /// Update mutable knowledge base fields
    /// 
    /// The `appId` field can be provided to update a knowledge base owned by a different app. 
    /// All other fields will overwrite the existing value on the knowledge base only if provided.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to patch.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patchKnowledgeBase(knowledgeBaseReferenceId: String, request: Requests.KnowledgeBasePatchRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBaseResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeBaseResponse.self
        )
    }

    /// Create a new knowledge base version.
    /// 
    /// If an existing version is in progress, then that version will be finalized in an error state.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to create a version for. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createKnowledgeBaseVersion(knowledgeBaseReferenceId: String, request: KnowledgeBaseVersionRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBaseVersion {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/version",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeBaseVersion.self
        )
    }

    /// Finalize the latest knowledge base version. Required to indicate the version is complete. Will throw an exception if the latest version is not in progress.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to finalize a version for. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func finalizeKnowledgeBaseVersion(knowledgeBaseReferenceId: String, request: FinalizeKnowledgeBaseVersionRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBaseVersion {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/version/finalize",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeBaseVersion.self
        )
    }

    /// List all active versions for a knowledge base. Returns the most recent versions first.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to list versions for. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the knowledge base. If not provided the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func listKnowledgeBaseVersions(knowledgeBaseReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> KnowledgeBaseVersionsListResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/versions",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: KnowledgeBaseVersionsListResponse.self
        )
    }

    /// Search knowledge documents
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func searchKnowledgeDocuments(request: KnowledgeDocumentSearchRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeDocumentsResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/knowledge/documents/search",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeDocumentsResponse.self
        )
    }

    /// Create or update a knowledge document. Requires an existing knowledge base with an in progress version. 
    /// Will throw an exception if the latest version is not in progress.
    ///         
    /// <Tip>
    /// This API maintains document version history. If for the same reference ID none of the `title`, `text`, `sourceUrl`, `metadata` fields 
    /// have changed, a new document version will not be created. The existing version will be reused.
    /// </Tip>
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to create a document for. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createKnowledgeDocument(knowledgeBaseReferenceId: String, request: KnowledgeDocumentRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeDocumentResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/document",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeDocumentResponse.self
        )
    }

    /// Delete knowledge document from a specific version. 
    /// Requires an existing knowledge base with an in progress version of type PARTIAL. Will throw an exception if the version is not in progress.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base that contains the document to delete. All other entity ID fields are inferred from the request
    /// - Parameter knowledgeDocumentReferenceId: The reference ID of the knowledge document to delete. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func deleteKnowledgeDocument(knowledgeBaseReferenceId: String, knowledgeDocumentReferenceId: String, request: KnowledgeDeleteRequest, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/\(knowledgeDocumentReferenceId)/document",
            body: request,
            requestOptions: requestOptions
        )
    }

    /// Get a knowledge document by its supplied version and document IDs. Response includes document content in markdown format.
    ///
    /// - Parameter knowledgeBaseVersionReferenceId: The reference ID of the knowledge base version that contains the document. All other entity ID fields are inferred from the request.
    /// - Parameter knowledgeDocumentReferenceId: The reference ID of the knowledge document to get. All other entity ID fields are inferred from the request.
    /// - Parameter knowledgeBaseVersionAppId: The App ID of the knowledge base version.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getKnowledgeDocument(knowledgeBaseVersionReferenceId: String, knowledgeDocumentReferenceId: String, knowledgeBaseVersionAppId: String, requestOptions: RequestOptions? = nil) async throws -> KnowledgeDocumentResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/knowledge/versions/\(knowledgeBaseVersionReferenceId)/documents/\(knowledgeDocumentReferenceId)",
            queryParams: [
                "knowledgeBaseVersionAppId": .string(knowledgeBaseVersionAppId)
            ],
            requestOptions: requestOptions,
            responseType: KnowledgeDocumentResponse.self
        )
    }

    /// Update mutable knowledge document fields that can be set independently of a knowledge base version.
    /// 
    /// For any changes in document content see the `createKnowledgeBaseVersion` and `createKnowledgeDocument` endpoints.
    /// 
    /// The `knowledgeBaseAppId` field can be provided to update a knowledge document in a knowledge base owned by a different app. 
    /// All other fields will overwrite the existing value on the knowledge document only if provided.
    ///
    /// - Parameter knowledgeBaseReferenceId: The reference ID of the knowledge base to patch.
    /// - Parameter knowledgeDocumentReferenceId: The reference ID of the knowledge document to patch.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patchKnowledgeDocument(knowledgeBaseReferenceId: String, knowledgeDocumentReferenceId: String, request: Requests.KnowledgeDocumentPatchRequest, requestOptions: RequestOptions? = nil) async throws -> KnowledgeDocumentResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/knowledge/\(knowledgeBaseReferenceId)/\(knowledgeDocumentReferenceId)/document",
            body: request,
            requestOptions: requestOptions,
            responseType: KnowledgeDocumentResponse.self
        )
    }
}