import Foundation

public final class AssetsClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Initiate an upload. 
    /// Returns a pre-signed URL for direct file upload and an asset ID for subsequent operations.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func initiateUpload(request: InitiateAssetUploadRequest, requestOptions: RequestOptions? = nil) async throws -> InitiateAssetUploadResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/assets",
            body: request,
            requestOptions: requestOptions,
            responseType: InitiateAssetUploadResponse.self
        )
    }

    /// Commit an upload after successful file transfer.
    /// Updates the asset status and makes it available for use.
    ///
    /// - Parameter assetReferenceId: The reference ID of the asset to commit (provided by the initiate call). All other entity ID fields are inferred from the API request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func commitUpload(assetReferenceId: String, request: CommitAssetUploadRequest, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/assets/\(assetReferenceId)/commit",
            body: request,
            requestOptions: requestOptions
        )
    }
}