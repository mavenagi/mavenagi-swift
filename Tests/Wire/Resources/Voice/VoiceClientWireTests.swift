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
                  "expiresIn": 1,
                  "connectUrl": "connectUrl"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = VoiceSessionTokenResponse(
            token: "token",
            identity: "identity",
            type: .webrtc,
            expiresIn: 1,
            connectUrl: Optional("connectUrl")
        )
        let response = try await client.voice.sessionToken(
            request: VoiceSessionTokenRequest(
                appUserId: "x",
                type: .webrtc
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}