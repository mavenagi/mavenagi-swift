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
                      "type": "CONVERSATION_CREATED",
                      "name": "name",
                      "description": "description",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "status": "ACTIVE"
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
                      "type": "CONVERSATION_CREATED",
                      "name": "name",
                      "description": "description",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "status": "ACTIVE"
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
                    type: .conversationCreated,
                    name: "name",
                    description: Optional("description"),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    status: .active
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
                    type: .conversationCreated,
                    name: "name",
                    description: Optional("description"),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    status: .active
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
                  "name": "Store in Snowflake",
                  "description": "Stores conversation data in Snowflake",
                  "type": "CONVERSATION_CREATED",
                  "enabled": true,
                  "createdAt": "2026-01-15T10:30:00Z",
                  "updatedAt": "2026-01-15T10:30:00Z",
                  "status": "ACTIVE"
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
            name: "Store in Snowflake",
            description: Optional("Stores conversation data in Snowflake"),
            type: .conversationCreated,
            enabled: true,
            createdAt: try! Date("2026-01-15T10:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2026-01-15T10:30:00Z", strategy: .iso8601),
            status: .active
        )
        let response = try await client.triggers.createOrUpdate(
            request: EventTriggerRequest(
                type: .conversationCreated,
                description: "Stores conversation data in Snowflake",
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
                  "name": "Store in Snowflake",
                  "description": "Stores conversation data in Snowflake",
                  "type": "CONVERSATION_CREATED",
                  "enabled": true,
                  "createdAt": "2026-01-15T10:30:00Z",
                  "updatedAt": "2026-01-15T10:30:00Z",
                  "status": "ACTIVE"
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
            name: "Store in Snowflake",
            description: Optional("Stores conversation data in Snowflake"),
            type: .conversationCreated,
            enabled: true,
            createdAt: try! Date("2026-01-15T10:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2026-01-15T10:30:00Z", strategy: .iso8601),
            status: .active
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
                  "type": "CONVERSATION_CREATED",
                  "name": "name",
                  "description": "description",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "status": "ACTIVE"
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
            type: .conversationCreated,
            name: "name",
            description: Optional("description"),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            status: .active
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