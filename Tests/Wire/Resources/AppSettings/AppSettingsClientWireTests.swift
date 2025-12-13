import Foundation
import Testing
import Api

@Suite("AppSettingsClient Wire Tests") struct AppSettingsClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "results": [
                    {
                      "organizationId": "organizationId",
                      "agentId": "agentId",
                      "settings": {
                        "settings": {
                          "key": "value"
                        }
                      }
                    },
                    {
                      "organizationId": "organizationId",
                      "agentId": "agentId",
                      "settings": {
                        "settings": {
                          "key": "value"
                        }
                      }
                    }
                  ]
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
        let expectedResponse = SearchAppSettingsResponse(
            results: [
                AppSettings(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    settings: [
                        "settings": JSONValue.object(
                            [
                                "key": JSONValue.string("value")
                            ]
                        )
                    ]
                ),
                AppSettings(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    settings: [
                        "settings": JSONValue.object(
                            [
                                "key": JSONValue.string("value")
                            ]
                        )
                    ]
                )
            ]
        )
        let response = try await client.appSettings.search(
            index: "index",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func get1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "string": {
                    "key": "value"
                  }
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
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.appSettings.get(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func update1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "string": {
                    "key": "value"
                  }
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
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.appSettings.update(
            request: [
                "string": .object([
                    "key": .string("value")
                ])
            ],
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}