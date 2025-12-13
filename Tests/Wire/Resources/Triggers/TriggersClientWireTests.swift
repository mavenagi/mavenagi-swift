import Foundation
import Testing
import Api

@Suite("TriggersClient Wire Tests") struct TriggersClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "triggers": [
                    {
                      "triggerId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "enabled": true,
                      "description": "description",
                      "type": "CONVERSATION_CREATED"
                    },
                    {
                      "triggerId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "enabled": true,
                      "description": "description",
                      "type": "CONVERSATION_CREATED"
                    }
                  ],
                  "number": 1,
                  "size": 1,
                  "totalElements": 1000000,
                  "totalPages": 1
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
        let expectedResponse = EventTriggersSearchResponse(
            triggers: [
                EventTriggerResponse(
                    triggerId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    enabled: true,
                    description: "description",
                    type: .conversationCreated
                ),
                EventTriggerResponse(
                    triggerId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    enabled: true,
                    description: "description",
                    type: .conversationCreated
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.triggers.search(
            request: EventTriggersSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createOrUpdate1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "triggerId": {
                    "referenceId": "store-in-snowflake",
                    "appId": "snowflake",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "EVENT_TRIGGER"
                  },
                  "description": "Stores conversation data in Snowflake",
                  "type": "CONVERSATION_CREATED",
                  "enabled": true
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
        let expectedResponse = EventTriggerResponse(
            triggerId: EntityId(
                referenceId: "store-in-snowflake",
                appId: "snowflake",
                organizationId: "acme",
                agentId: "support",
                type: .eventTrigger
            ),
            description: "Stores conversation data in Snowflake",
            type: .conversationCreated,
            enabled: true
        )
        let response = try await client.triggers.createOrUpdate(
            request: EventTriggerRequest(
                description: "Stores conversation data in Snowflake",
                type: .conversationCreated,
                triggerId: EntityIdBase(
                    referenceId: "store-in-snowflake"
                )
            ),
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
                  "triggerId": {
                    "referenceId": "store-in-snowflake",
                    "appId": "snowflake",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "EVENT_TRIGGER"
                  },
                  "description": "Stores conversation data in Snowflake",
                  "type": "CONVERSATION_CREATED",
                  "enabled": true
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
        let expectedResponse = EventTriggerResponse(
            triggerId: EntityId(
                referenceId: "store-in-snowflake",
                appId: "snowflake",
                organizationId: "acme",
                agentId: "support",
                type: .eventTrigger
            ),
            description: "Stores conversation data in Snowflake",
            type: .conversationCreated,
            enabled: true
        )
        let response = try await client.triggers.get(
            triggerReferenceId: "store-in-snowflake",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func partialUpdate1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "triggerId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "enabled": true,
                  "description": "description",
                  "type": "CONVERSATION_CREATED"
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
        let expectedResponse = EventTriggerResponse(
            triggerId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            enabled: true,
            description: "description",
            type: .conversationCreated
        )
        let response = try await client.triggers.partialUpdate(
            triggerReferenceId: "triggerReferenceId",
            request: .init(body: TriggerPartialUpdate(

            )),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}