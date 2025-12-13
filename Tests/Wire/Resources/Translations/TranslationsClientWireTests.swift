import Foundation
import Testing
import Api

@Suite("TranslationsClient Wire Tests") struct TranslationsClientWireTests {
    @Test func translate1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "translatedText": "Hola mundo"
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
        let expectedResponse = TranslationResponse(
            translatedText: "Hola mundo"
        )
        let response = try await client.translations.translate(
            request: TranslationRequest(
                text: "Hello world",
                targetLanguage: "es"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}