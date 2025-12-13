import Foundation

public final class SegmentsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    public func search(request: SegmentsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> SegmentsSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/segments",
            body: request,
            requestOptions: requestOptions,
            responseType: SegmentsSearchResponse.self
        )
    }

    /// Update a segment or create it if it doesn't exist.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: SegmentRequest, requestOptions: RequestOptions? = nil) async throws -> SegmentResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/segments",
            body: request,
            requestOptions: requestOptions,
            responseType: SegmentResponse.self
        )
    }

    /// Get a segment by its supplied ID
    ///
    /// - Parameter segmentReferenceId: The reference ID of the segment to get. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the segment to get. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(segmentReferenceId: String, appId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> SegmentResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/segments/\(segmentReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: SegmentResponse.self
        )
    }

    /// Update mutable segment fields
    /// 
    /// The `appId` field can be provided to update a segment owned by a different app. 
    /// All other fields will overwrite the existing value on the segment only if provided.
    ///
    /// - Parameter segmentReferenceId: The reference ID of the segment to update. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(segmentReferenceId: String, request: SegmentPatchRequest, requestOptions: RequestOptions? = nil) async throws -> SegmentResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/segments/\(segmentReferenceId)",
            body: request,
            requestOptions: requestOptions,
            responseType: SegmentResponse.self
        )
    }
}