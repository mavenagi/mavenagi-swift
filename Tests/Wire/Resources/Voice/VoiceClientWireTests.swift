import Foundation
import Testing
import Api

@Suite("VoiceClient Wire Tests") struct VoiceClientWireTests {
    @Test func sessionToken1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "token": "token",
                  "identity": "identity",
                  "type": "webrtc",
                  "expiresIn": 1
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
        let expectedResponse = VoiceSessionTokenResponse(
            token: "token",
            identity: "identity",
            type: .webrtc,
            expiresIn: 1
        )
        let response = try await client.voice.sessionToken(
            request: VoiceSessionTokenRequest(
                appUserId: "appUserId",
                type: .webrtc
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}