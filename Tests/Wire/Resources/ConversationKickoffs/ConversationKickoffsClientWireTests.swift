import Foundation
import Testing
import Api

@Suite("ConversationKickoffsClient Wire Tests") struct ConversationKickoffsClientWireTests {
    @Test func createOrUpdate1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "kickoffId": {
                    "referenceId": "greet-returning-customer",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CONVERSATION_KICKOFF"
                  },
                  "name": "Greet returning customer",
                  "description": "Looks up the customer's open orders before the agent's first reply",
                  "status": "INACTIVE",
                  "createdAt": "2026-01-15T10:30:00Z",
                  "updatedAt": "2026-01-15T10:30:00Z"
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
        let expectedResponse = ConversationKickoff(
            kickoffId: EntityId(
                referenceId: "greet-returning-customer",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .conversationKickoff
            ),
            name: "Greet returning customer",
            description: Optional("Looks up the customer's open orders before the agent's first reply"),
            status: .inactive,
            createdAt: try! Date("2026-01-15T10:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2026-01-15T10:30:00Z", strategy: .iso8601)
        )
        let response = try await client.conversationKickoffs.createOrUpdate(
            request: .init(
                kickoffId: EntityIdBase(
                    referenceId: "greet-returning-customer"
                ),
                name: "Greet returning customer",
                description: "Looks up the customer's open orders before the agent's first reply"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}