import Foundation
import Testing
import Api

@Suite("AssetsClient Wire Tests") struct AssetsClientWireTests {
    @Test func initiateUpload1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "assetId": {
                    "referenceId": "x"
                  },
                  "uploadUrl": "uploadUrl",
                  "expiresAt": "2024-01-15T09:30:00Z"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            appId: "<username>",
            appSecret: "<password>",
            urlSession: stub.urlSession
        )
        let expectedResponse = InitiateAssetUploadResponse(
            assetId: EntityIdBase(
                referenceId: "x"
            ),
            uploadUrl: "uploadUrl",
            expiresAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
        )
        let response = try await client.assets.initiateUpload(
            request: InitiateAssetUploadRequest(
                type: "type"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}