import Foundation

public final class ChartersClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create a new charter or update an existing one. Charters are governing
    /// documents that combine a precondition (when the charter applies), a manual
    /// (what the LLM should do), and the knowledge bases and actions the charter
    /// makes available.
    /// 
    /// All charters in an agent form a tree (forest / multi-roots). When a
    /// charter is matched on a round, all its ancestor charters will be
    /// incorporated. Non-leaf charters are referred to as a charter group.
    /// 
    /// Charters may specify a 0-indexed custom `userRank` that indicates
    /// preferences among its siblings. The rank is currently only meaningful
    /// for leaf charters as we enforce mutual exclusion among the leafs and
    /// pick only the highest ranked (lowest numerical value) leaf to include in
    /// the round. userRank may have gaps.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: CharterRequest, requestOptions: RequestOptions? = nil) async throws -> CharterResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/charters",
            body: request,
            requestOptions: requestOptions,
            responseType: CharterResponse.self
        )
    }

    /// Get a charter by its reference ID.
    ///
    /// - Parameter charterReferenceId: The reference ID of the charter to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the charter to get. If not provided, the ID of the calling app will be used.
    /// - Parameter variantReferenceId: The agent variant reference ID to resolve the charter's version through. If not provided, defaults to the agent's production variant. Currently, validated but not applied.
    /// - Parameter variantAppId: The App ID of the agent variant reference. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(charterReferenceId: String, appId: String? = nil, variantReferenceId: String? = nil, variantAppId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> CharterResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/charters/\(charterReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "variantReferenceId": variantReferenceId.map { .string($0) }, 
                "variantAppId": variantAppId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: CharterResponse.self
        )
    }

    /// Update mutable fields on a charter. Only provided fields are modified.
    /// 
    /// To move a charter within the tree, set `parentCharterId`.
    /// To promote to root level, set `parentCharterId` explicitly to null.
    /// 
    /// **Status behavior**:
    ///   - Setting `status` to `INACTIVE` applies only to the targeted charter;
    ///     it does not cascade to descendants. However, its descendants will no
    ///     longer be incorporated at runtime.
    ///   - Setting `status` to `ACTIVE` applies only to the targeted charter.
    ///     The caller is responsible for ensuring ancestor charters are also `ACTIVE`
    ///     if the full subtree should be reachable at runtime.
    /// 
    /// **userRank conflict resolution**: When `userRank` is set to a value already held by a
    /// sibling, siblings at that rank and above are shifted up by 1 (like linked list semantics).
    /// The caller does not need to manage uniqueness explicitly.
    ///
    /// - Parameter charterReferenceId: The reference ID of the charter to patch.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(charterReferenceId: String, request: Requests.CharterPatchRequest, requestOptions: RequestOptions? = nil) async throws -> CharterResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/charters/\(charterReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: CharterResponse.self
        )
    }

    /// Delete a charter and all of its descendants recursively.
    /// 
    /// The charter must be set to `INACTIVE` before it can be deleted. This prevents accidental
    /// deletion of active charters. Descendant charters may be in any status — they will be
    /// soft-deleted regardless.
    /// 
    /// Deleted charters are excluded from list results but can be retrieved by ID for archival purposes.
    /// 
    /// Deleted charters cannot be modified.
    ///
    /// - Parameter charterReferenceId: The reference ID of the charter to delete.
    /// - Parameter appId: The App ID of the charter to delete. If not provided, the ID of the calling app will be used.
    /// - Parameter variantReferenceId: The reference ID of the agent variant this delete is scoped to. When set, the
    /// deletion is staged in that variant's working set instead of being applied to the
    /// agent's live configuration.
    /// 
    /// Omit this parameter to delete directly from the agent. Variant scoping is not
    /// active yet: a variant supplied today is validated but not applied, and the delete applies
    /// to the agent.
    /// - Parameter variantAppId: The App ID of the agent variant named by `variantReferenceId`. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(charterReferenceId: String, appId: String? = nil, variantReferenceId: String? = nil, variantAppId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> CharterResponse {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/charters/\(charterReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "variantReferenceId": variantReferenceId.map { .string($0) }, 
                "variantAppId": variantAppId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: CharterResponse.self
        )
    }

    /// Search for charters matching the provided filters. Supports filtering by
    /// referenced action IDs and knowledge base IDs to find charters that make
    /// specific context items available.
    /// 
    /// Returns both ACTIVE and INACTIVE charters (DELETED charters are excluded).
    /// 
    /// Results are ordered by the `sort` field (defaults to CreatedAt). Use `sortDesc`
    /// to control direction (defaults to descending). An empty filter list is
    /// equivalent to omitting the field (no filter applied).
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: CharterSearchRequest, requestOptions: RequestOptions? = nil) async throws -> CharterSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/charters/search",
            body: request,
            requestOptions: requestOptions,
            responseType: CharterSearchResponse.self
        )
    }

    /// Return a flat list containing the specified charter and all of its ancestors
    /// up to the root. Useful for rendering tree context around search results.
    /// 
    /// Each entry is a full charter, so an ancestor's references and precondition are
    /// readable without a follow-up request per level.
    /// 
    /// The list is always finite: charter hierarchies are acyclic, so a charter is never its own
    /// ancestor and the walk to the root terminates.
    /// 
    /// Returns 404 if the charter does not exist or is deleted.
    ///
    /// - Parameter charterReferenceId: The reference ID of the charter. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the charter. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getAncestors(charterReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> CharterAncestorsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/charters/\(charterReferenceId)/ancestors",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: CharterAncestorsResponse.self
        )
    }

    /// Batch fetch direct children of the specified parent charters. Returns one
    /// group per requested parent in the same order as parentIds, with grandchild
    /// IDs populated on each child for expandability signals.
    /// 
    /// Pass an empty parentIds list to fetch all root-level charters for the agent.
    /// Intended to be used for easy BFS traversal, though calling with parents
    /// at mixed levels are allowed. Roots and specific parents cannot be mixed
    /// in one request.
    /// 
    /// DELETED charters are never returned.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func listChildren(request: CharterListChildrenRequest, requestOptions: RequestOptions? = nil) async throws -> CharterListChildrenResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/charters/list-children",
            body: request,
            requestOptions: requestOptions,
            responseType: CharterListChildrenResponse.self
        )
    }
}