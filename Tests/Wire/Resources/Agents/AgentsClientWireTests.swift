import Foundation
import Testing
import Api

@Suite("AgentsClient Wire Tests") struct AgentsClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "agents": [
                    {
                      "agentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "name": "name",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "environment": "DEMO",
                      "defaultTimezone": "defaultTimezone",
                      "enabledPiiCategories": [
                        "Name"
                      ],
                      "systemFallbackMessage": "systemFallbackMessage",
                      "prompting": {
                        "persona": "CASUAL_BUDDY",
                        "additionalPromptText": "additionalPromptText",
                        "categoryGenerationPromptText": "categoryGenerationPromptText",
                        "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                        "rejectQuestionsWithoutKnowledge": true
                      }
                    },
                    {
                      "agentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "name": "name",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "environment": "DEMO",
                      "defaultTimezone": "defaultTimezone",
                      "enabledPiiCategories": [
                        "Name"
                      ],
                      "systemFallbackMessage": "systemFallbackMessage",
                      "prompting": {
                        "persona": "CASUAL_BUDDY",
                        "additionalPromptText": "additionalPromptText",
                        "categoryGenerationPromptText": "categoryGenerationPromptText",
                        "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                        "rejectQuestionsWithoutKnowledge": true
                      }
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
        let expectedResponse = AgentsSearchResponse(
            agents: [
                Agent(
                    agentId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    name: "name",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    environment: .demo,
                    defaultTimezone: "defaultTimezone",
                    enabledPiiCategories: [],
                    systemFallbackMessage: Optional("systemFallbackMessage"),
                    prompting: AgentPrompting(
                        persona: .casualBuddy,
                        additionalPromptText: Optional("additionalPromptText"),
                        categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                        contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                        rejectQuestionsWithoutKnowledge: true
                    )
                ),
                Agent(
                    agentId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    name: "name",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    environment: .demo,
                    defaultTimezone: "defaultTimezone",
                    enabledPiiCategories: [],
                    systemFallbackMessage: Optional("systemFallbackMessage"),
                    prompting: AgentPrompting(
                        persona: .casualBuddy,
                        additionalPromptText: Optional("additionalPromptText"),
                        categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                        contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                        rejectQuestionsWithoutKnowledge: true
                    )
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.agents.search(
            request: AgentsSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func list1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                [
                  {
                    "agentId": {
                      "organizationId": "organizationId",
                      "agentId": "agentId",
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "name": "name",
                    "createdAt": "2024-01-15T09:30:00Z",
                    "environment": "DEMO",
                    "defaultTimezone": "defaultTimezone",
                    "enabledPiiCategories": [
                      "Name"
                    ],
                    "systemFallbackMessage": "systemFallbackMessage",
                    "prompting": {
                      "persona": "CASUAL_BUDDY",
                      "additionalPromptText": "additionalPromptText",
                      "categoryGenerationPromptText": "categoryGenerationPromptText",
                      "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                      "rejectQuestionsWithoutKnowledge": true
                    }
                  },
                  {
                    "agentId": {
                      "organizationId": "organizationId",
                      "agentId": "agentId",
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "name": "name",
                    "createdAt": "2024-01-15T09:30:00Z",
                    "environment": "DEMO",
                    "defaultTimezone": "defaultTimezone",
                    "enabledPiiCategories": [
                      "Name"
                    ],
                    "systemFallbackMessage": "systemFallbackMessage",
                    "prompting": {
                      "persona": "CASUAL_BUDDY",
                      "additionalPromptText": "additionalPromptText",
                      "categoryGenerationPromptText": "categoryGenerationPromptText",
                      "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                      "rejectQuestionsWithoutKnowledge": true
                    }
                  }
                ]
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
            Agent(
                agentId: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                name: "name",
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                environment: .demo,
                defaultTimezone: "defaultTimezone",
                enabledPiiCategories: [],
                systemFallbackMessage: Optional("systemFallbackMessage"),
                prompting: AgentPrompting(
                    persona: .casualBuddy,
                    additionalPromptText: Optional("additionalPromptText"),
                    categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                    contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                    rejectQuestionsWithoutKnowledge: true
                )
            ),
            Agent(
                agentId: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                name: "name",
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                environment: .demo,
                defaultTimezone: "defaultTimezone",
                enabledPiiCategories: [],
                systemFallbackMessage: Optional("systemFallbackMessage"),
                prompting: AgentPrompting(
                    persona: .casualBuddy,
                    additionalPromptText: Optional("additionalPromptText"),
                    categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                    contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                    rejectQuestionsWithoutKnowledge: true
                )
            )
        ]
        let response = try await client.agents.list(
            organizationReferenceId: "organizationReferenceId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func create1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "agentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "name": "name",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "environment": "DEMO",
                  "defaultTimezone": "defaultTimezone",
                  "enabledPiiCategories": [
                    "Name"
                  ],
                  "systemFallbackMessage": "systemFallbackMessage",
                  "prompting": {
                    "persona": "CASUAL_BUDDY",
                    "additionalPromptText": "additionalPromptText",
                    "categoryGenerationPromptText": "categoryGenerationPromptText",
                    "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                    "rejectQuestionsWithoutKnowledge": true
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
        let expectedResponse = Agent(
            agentId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            name: "name",
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            environment: .demo,
            defaultTimezone: "defaultTimezone",
            enabledPiiCategories: [],
            systemFallbackMessage: Optional("systemFallbackMessage"),
            prompting: AgentPrompting(
                persona: .casualBuddy,
                additionalPromptText: Optional("additionalPromptText"),
                categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                rejectQuestionsWithoutKnowledge: true
            )
        )
        let response = try await client.agents.create(
            organizationReferenceId: "organizationReferenceId",
            agentReferenceId: "agentReferenceId",
            request: CreateAgentRequest(
                name: "name",
                environment: .demo
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
                  "agentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "name": "name",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "environment": "DEMO",
                  "defaultTimezone": "defaultTimezone",
                  "enabledPiiCategories": [
                    "Name"
                  ],
                  "systemFallbackMessage": "systemFallbackMessage",
                  "prompting": {
                    "persona": "CASUAL_BUDDY",
                    "additionalPromptText": "additionalPromptText",
                    "categoryGenerationPromptText": "categoryGenerationPromptText",
                    "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                    "rejectQuestionsWithoutKnowledge": true
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
        let expectedResponse = Agent(
            agentId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            name: "name",
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            environment: .demo,
            defaultTimezone: "defaultTimezone",
            enabledPiiCategories: [],
            systemFallbackMessage: Optional("systemFallbackMessage"),
            prompting: AgentPrompting(
                persona: .casualBuddy,
                additionalPromptText: Optional("additionalPromptText"),
                categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                rejectQuestionsWithoutKnowledge: true
            )
        )
        let response = try await client.agents.get(
            organizationReferenceId: "organizationReferenceId",
            agentReferenceId: "agentReferenceId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func patch1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "agentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "name": "name",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "environment": "DEMO",
                  "defaultTimezone": "defaultTimezone",
                  "enabledPiiCategories": [
                    "Name"
                  ],
                  "systemFallbackMessage": "systemFallbackMessage",
                  "prompting": {
                    "persona": "CASUAL_BUDDY",
                    "additionalPromptText": "additionalPromptText",
                    "categoryGenerationPromptText": "categoryGenerationPromptText",
                    "contentSafetyViolationResponsePromptText": "contentSafetyViolationResponsePromptText",
                    "rejectQuestionsWithoutKnowledge": true
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
        let expectedResponse = Agent(
            agentId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            name: "name",
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            environment: .demo,
            defaultTimezone: "defaultTimezone",
            enabledPiiCategories: [],
            systemFallbackMessage: Optional("systemFallbackMessage"),
            prompting: AgentPrompting(
                persona: .casualBuddy,
                additionalPromptText: Optional("additionalPromptText"),
                categoryGenerationPromptText: Optional("categoryGenerationPromptText"),
                contentSafetyViolationResponsePromptText: Optional("contentSafetyViolationResponsePromptText"),
                rejectQuestionsWithoutKnowledge: true
            )
        )
        let response = try await client.agents.patch(
            organizationReferenceId: "organizationReferenceId",
            agentReferenceId: "agentReferenceId",
            request: .init(),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}