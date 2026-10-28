import Foundation
import Testing
import Api

@Suite("CapabilitiesClient Wire Tests") struct CapabilitiesClientWireTests {
    @Test func getCapability1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "capabilityType": "ACTION",
                  "actionId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "functionBinding": {
                    "functionId": {
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "versionId": {
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    }
                  },
                  "instructions": "instructions",
                  "llmInclusionStatus": "ALWAYS",
                  "segmentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "preconditionExplanation": "preconditionExplanation",
                  "deleted": true,
                  "userInteractionRequired": true,
                  "buttonName": "buttonName",
                  "precondition": {
                    "preconditionType": "user",
                    "key": "key",
                    "value": "value",
                    "values": [
                      "values",
                      "values"
                    ],
                    "operator": "NOT"
                  },
                  "userFormParameters": [
                    {
                      "id": "id",
                      "label": "label",
                      "description": "description",
                      "required": true,
                      "hidden": true,
                      "type": "STRING",
                      "enumOptions": [
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        },
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        }
                      ],
                      "schema": "schema",
                      "oauthConfiguration": {
                        "authorizationUrl": "authorizationUrl",
                        "tokenUrl": "tokenUrl",
                        "clientId": "clientId",
                        "clientSecret": "clientSecret",
                        "scopes": [
                          "scopes",
                          "scopes"
                        ],
                        "extraAuthParams": {
                          "extraAuthParams": "extraAuthParams"
                        },
                        "extraTokenParams": {
                          "extraTokenParams": "extraTokenParams"
                        }
                      }
                    },
                    {
                      "id": "id",
                      "label": "label",
                      "description": "description",
                      "required": true,
                      "hidden": true,
                      "type": "STRING",
                      "enumOptions": [
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        },
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        }
                      ],
                      "schema": "schema",
                      "oauthConfiguration": {
                        "authorizationUrl": "authorizationUrl",
                        "tokenUrl": "tokenUrl",
                        "clientId": "clientId",
                        "clientSecret": "clientSecret",
                        "scopes": [
                          "scopes",
                          "scopes"
                        ],
                        "extraAuthParams": {
                          "extraAuthParams": "extraAuthParams"
                        },
                        "extraTokenParams": {
                          "extraTokenParams": "extraTokenParams"
                        }
                      }
                    }
                  ],
                  "language": "language",
                  "sideEffects": "NONE",
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
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = .action(
            .init(
                actionId: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                instructions: Optional("instructions"),
                llmInclusionStatus: .always,
                segmentId: Optional(EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                )),
                preconditionExplanation: Optional("preconditionExplanation"),
                deleted: true,
                userInteractionRequired: true,
                buttonName: Optional("buttonName"),
                precondition: Optional(.user(
                    .init(
                        key: "key",
                        value: Optional("value"),
                        values: Optional([
                            "values",
                            "values"
                        ]),
                        operator: Optional(.not)
                    )
                )),
                userFormParameters: [
                    ActionParameter(
                        id: "id",
                        label: "label",
                        description: "description",
                        required: true,
                        hidden: Optional(true),
                        type: Optional(.string),
                        enumOptions: Optional([
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            ),
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            )
                        ]),
                        schema: Optional("schema"),
                        oauthConfiguration: Optional(ActionOAuthConfiguration(
                            authorizationUrl: "authorizationUrl",
                            tokenUrl: "tokenUrl",
                            clientId: "clientId",
                            clientSecret: "clientSecret",
                            scopes: [
                                "scopes",
                                "scopes"
                            ],
                            extraAuthParams: Optional([
                                "extraAuthParams": "extraAuthParams"
                            ]),
                            extraTokenParams: Optional([
                                "extraTokenParams": "extraTokenParams"
                            ])
                        ))
                    ),
                    ActionParameter(
                        id: "id",
                        label: "label",
                        description: "description",
                        required: true,
                        hidden: Optional(true),
                        type: Optional(.string),
                        enumOptions: Optional([
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            ),
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            )
                        ]),
                        schema: Optional("schema"),
                        oauthConfiguration: Optional(ActionOAuthConfiguration(
                            authorizationUrl: "authorizationUrl",
                            tokenUrl: "tokenUrl",
                            clientId: "clientId",
                            clientSecret: "clientSecret",
                            scopes: [
                                "scopes",
                                "scopes"
                            ],
                            extraAuthParams: Optional([
                                "extraAuthParams": "extraAuthParams"
                            ]),
                            extraTokenParams: Optional([
                                "extraTokenParams": "extraTokenParams"
                            ])
                        ))
                    )
                ],
                language: Optional("language"),
                sideEffects: Optional(.none),
                name: "name",
                description: Optional("description"),
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                status: .active
            )
        )
        let response = try await client.capabilities.getCapability(
            capabilityType: .action,
            referenceId: "referenceId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func patchCapability1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "capabilityType": "ACTION",
                  "actionId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "functionBinding": {
                    "functionId": {
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "versionId": {
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    }
                  },
                  "instructions": "instructions",
                  "llmInclusionStatus": "ALWAYS",
                  "segmentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "preconditionExplanation": "preconditionExplanation",
                  "deleted": true,
                  "userInteractionRequired": true,
                  "buttonName": "buttonName",
                  "precondition": {
                    "preconditionType": "user",
                    "key": "key",
                    "value": "value",
                    "values": [
                      "values",
                      "values"
                    ],
                    "operator": "NOT"
                  },
                  "userFormParameters": [
                    {
                      "id": "id",
                      "label": "label",
                      "description": "description",
                      "required": true,
                      "hidden": true,
                      "type": "STRING",
                      "enumOptions": [
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        },
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        }
                      ],
                      "schema": "schema",
                      "oauthConfiguration": {
                        "authorizationUrl": "authorizationUrl",
                        "tokenUrl": "tokenUrl",
                        "clientId": "clientId",
                        "clientSecret": "clientSecret",
                        "scopes": [
                          "scopes",
                          "scopes"
                        ],
                        "extraAuthParams": {
                          "extraAuthParams": "extraAuthParams"
                        },
                        "extraTokenParams": {
                          "extraTokenParams": "extraTokenParams"
                        }
                      }
                    },
                    {
                      "id": "id",
                      "label": "label",
                      "description": "description",
                      "required": true,
                      "hidden": true,
                      "type": "STRING",
                      "enumOptions": [
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        },
                        {
                          "label": "label",
                          "value": {
                            "key": "value"
                          }
                        }
                      ],
                      "schema": "schema",
                      "oauthConfiguration": {
                        "authorizationUrl": "authorizationUrl",
                        "tokenUrl": "tokenUrl",
                        "clientId": "clientId",
                        "clientSecret": "clientSecret",
                        "scopes": [
                          "scopes",
                          "scopes"
                        ],
                        "extraAuthParams": {
                          "extraAuthParams": "extraAuthParams"
                        },
                        "extraTokenParams": {
                          "extraTokenParams": "extraTokenParams"
                        }
                      }
                    }
                  ],
                  "language": "language",
                  "sideEffects": "NONE",
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
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = .action(
            .init(
                actionId: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                instructions: Optional("instructions"),
                llmInclusionStatus: .always,
                segmentId: Optional(EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                )),
                preconditionExplanation: Optional("preconditionExplanation"),
                deleted: true,
                userInteractionRequired: true,
                buttonName: Optional("buttonName"),
                precondition: Optional(.user(
                    .init(
                        key: "key",
                        value: Optional("value"),
                        values: Optional([
                            "values",
                            "values"
                        ]),
                        operator: Optional(.not)
                    )
                )),
                userFormParameters: [
                    ActionParameter(
                        id: "id",
                        label: "label",
                        description: "description",
                        required: true,
                        hidden: Optional(true),
                        type: Optional(.string),
                        enumOptions: Optional([
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            ),
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            )
                        ]),
                        schema: Optional("schema"),
                        oauthConfiguration: Optional(ActionOAuthConfiguration(
                            authorizationUrl: "authorizationUrl",
                            tokenUrl: "tokenUrl",
                            clientId: "clientId",
                            clientSecret: "clientSecret",
                            scopes: [
                                "scopes",
                                "scopes"
                            ],
                            extraAuthParams: Optional([
                                "extraAuthParams": "extraAuthParams"
                            ]),
                            extraTokenParams: Optional([
                                "extraTokenParams": "extraTokenParams"
                            ])
                        ))
                    ),
                    ActionParameter(
                        id: "id",
                        label: "label",
                        description: "description",
                        required: true,
                        hidden: Optional(true),
                        type: Optional(.string),
                        enumOptions: Optional([
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            ),
                            ActionEnumOption(
                                label: "label",
                                value: JSONValue.object(
                                    [
                                        "key": JSONValue.string("value")
                                    ]
                                )
                            )
                        ]),
                        schema: Optional("schema"),
                        oauthConfiguration: Optional(ActionOAuthConfiguration(
                            authorizationUrl: "authorizationUrl",
                            tokenUrl: "tokenUrl",
                            clientId: "clientId",
                            clientSecret: "clientSecret",
                            scopes: [
                                "scopes",
                                "scopes"
                            ],
                            extraAuthParams: Optional([
                                "extraAuthParams": "extraAuthParams"
                            ]),
                            extraTokenParams: Optional([
                                "extraTokenParams": "extraTokenParams"
                            ])
                        ))
                    )
                ],
                language: Optional("language"),
                sideEffects: Optional(.none),
                name: "name",
                description: Optional("description"),
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                status: .active
            )
        )
        let response = try await client.capabilities.patchCapability(
            capabilityType: .action,
            referenceId: "referenceId",
            request: .init(),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func simulateCapability1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "capabilityType": "ACTION",
                  "response": "response",
                  "data": {
                    "data": {
                      "key": "value"
                    }
                  },
                  "status": "SUCCESS",
                  "errorMessage": "errorMessage"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = .action(
            .init(
                response: "response",
                data: Optional([
                    "data": JSONValue.object(
                        [
                            "key": JSONValue.string("value")
                        ]
                    )
                ]),
                status: Optional(.success),
                errorMessage: Optional("errorMessage")
            )
        )
        let response = try await client.capabilities.simulateCapability(
            capabilityType: .action,
            referenceId: "referenceId",
            request: .init(body: CapabilitySimulationInput.action(
                .init(

                )
            )),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func searchCapabilities1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "capabilities": [
                    {
                      "capabilityId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "capabilityType": "ACTION",
                      "name": "name",
                      "description": "description",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "status": "ACTIVE"
                    },
                    {
                      "capabilityId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "capabilityType": "ACTION",
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
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CapabilitiesSearchResponse(
            capabilities: [
                CapabilitySummary(
                    capabilityId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    capabilityType: .action,
                    name: "name",
                    description: Optional("description"),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    status: .active
                ),
                CapabilitySummary(
                    capabilityId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    capabilityType: .action,
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
        let response = try await client.capabilities.searchCapabilities(
            request: .init(),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func searchCapabilityExecutions1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "number": 0,
                  "size": 2,
                  "totalElements": 2,
                  "totalPages": 1,
                  "executions": [
                    {
                      "capabilityType": "TRIGGER",
                      "capabilityId": {
                        "referenceId": "store-in-snowflake",
                        "appId": "snowflake",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "EVENT_TRIGGER"
                      },
                      "subjectId": {
                        "referenceId": "conversation-123",
                        "appId": "zendesk",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION"
                      },
                      "status": "SUCCESS",
                      "completionReason": "SUCCESS",
                      "startedAt": "2026-08-31T10:30:05Z",
                      "completedAt": "2026-08-31T10:30:06Z",
                      "durationMs": 1120,
                      "createdAt": "2026-08-31T10:30:05Z",
                      "executionMode": "LIVE",
                      "eventType": "CONVERSATION_CREATED",
                      "attempt": 1
                    },
                    {
                      "capabilityType": "CONVERSATION_KICKOFF",
                      "capabilityId": {
                        "referenceId": "greet-returning-customer",
                        "appId": "my-billing-system",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION_KICKOFF"
                      },
                      "subjectId": {
                        "referenceId": "conversation-123",
                        "appId": "zendesk",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION"
                      },
                      "status": "FAILED",
                      "completionReason": "TIMEOUT",
                      "message": "Conversation Kickoff timed out",
                      "startedAt": "2026-08-31T10:30:00Z",
                      "completedAt": "2026-08-31T10:30:04Z",
                      "durationMs": 4000,
                      "createdAt": "2026-08-31T10:30:00Z",
                      "executionMode": "LIVE"
                    }
                  ]
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CapabilityExecutionsSearchResponse(
            number: 0,
            size: 2,
            totalElements: 2,
            totalPages: 1,
            executions: [
                .trigger(
                    .init(
                        capabilityId: EntityId(
                            referenceId: "store-in-snowflake",
                            appId: "snowflake",
                            organizationId: "acme",
                            agentId: "support",
                            type: .eventTrigger
                        ),
                        subjectId: EntityId(
                            referenceId: "conversation-123",
                            appId: "zendesk",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversation
                        ),
                        status: .success,
                        completionReason: Optional(.success),
                        startedAt: try! Date("2026-08-31T10:30:05Z", strategy: .iso8601),
                        completedAt: Optional(try! Date("2026-08-31T10:30:06Z", strategy: .iso8601)),
                        durationMs: Optional(1120),
                        createdAt: try! Date("2026-08-31T10:30:05Z", strategy: .iso8601),
                        executionMode: .live,
                        eventType: .conversationCreated,
                        attempt: 1
                    )
                ),
                .conversationKickoff(
                    .init(
                        capabilityId: EntityId(
                            referenceId: "greet-returning-customer",
                            appId: "my-billing-system",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversationKickoff
                        ),
                        subjectId: EntityId(
                            referenceId: "conversation-123",
                            appId: "zendesk",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversation
                        ),
                        status: .failed,
                        completionReason: Optional(.timeout),
                        message: Optional("Conversation Kickoff timed out"),
                        startedAt: try! Date("2026-08-31T10:30:00Z", strategy: .iso8601),
                        completedAt: Optional(try! Date("2026-08-31T10:30:04Z", strategy: .iso8601)),
                        durationMs: Optional(4000),
                        createdAt: try! Date("2026-08-31T10:30:00Z", strategy: .iso8601),
                        executionMode: .live
                    )
                )
            ]
        )
        let response = try await client.capabilities.searchCapabilityExecutions(
            request: .init(subjectIds: [
                EntityId(
                    type: .conversation,
                    appId: "zendesk",
                    referenceId: "conversation-123",
                    organizationId: "acme",
                    agentId: "support"
                )
            ]),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}