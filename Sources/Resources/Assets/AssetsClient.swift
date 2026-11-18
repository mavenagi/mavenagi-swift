import Foundation

public final class AssetsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Initiate an upload. 
    /// Returns a pre-signed URL for direct file upload and an asset ID for subsequent operations.
    /// 
    /// <Note>**Required permission:** `ask:agent`</Note>
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
    /// An asset is committed once. Committing it again with the same checksum is safe while its file
    /// is unchanged, so a client can retry a commit; a different checksum returns a 409. Once
    /// committed, don't write to the upload URL again, even with the same bytes: committing after
    /// that may return a 409, and the file then has to be uploaded as a new asset.
    /// 
    /// <Note>**Required permission:** `ask:agent`</Note>
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