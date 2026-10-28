import Foundation
import Testing
import Api

@Suite("ChartersClient Wire Tests") struct ChartersClientWireTests {
    @Test func createOrUpdate1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "charterId": {
                    "referenceId": "cancellation-flow",
                    "appId": "support-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CHARTER"
                  },
                  "name": "Cancellation Flow",
                  "manual": "Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding.",
                  "childCharterIds": [],
                  "references": {
                    "knowledgeBases": [],
                    "actionIds": []
                  },
                  "precondition": {
                    "preconditionType": "conversation",
                    "value": {
                      "conversationPreconditionType": "tags",
                      "tags": [
                        "cancellation"
                      ]
                    }
                  },
                  "status": "ACTIVE",
                  "type": "STANDARD",
                  "userRank": 0,
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-01-15T12:30:00Z"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CharterResponse(
            charterId: EntityId(
                referenceId: "cancellation-flow",
                appId: "support-app",
                organizationId: "acme",
                agentId: "support",
                type: .charter
            ),
            name: "Cancellation Flow",
            manual: Optional("Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding."),
            childCharterIds: [],
            references: CharterReferences(
                knowledgeBases: Optional([]),
                actionIds: []
            ),
            precondition: Optional(.tags(
                .init(
                    tags: []
                )
            )),
            status: .active,
            type: Optional(.standard),
            userRank: 0,
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
        )
        let response = try await client.charters.createOrUpdate(
            request: CharterRequest(
                parentCharterId: .null,
                segmentId: .null,
                precondition: .value(Precondition.conversation(
                    .init(
                        conversation: 
                    )
                )),
                status: .active,
                type: .standard,
                references: CharterReferences(
                    knowledgeBases: []
                ),
                name: "Cancellation Flow",
                manual: "Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding.",
                charterId: EntityIdBase(
                    referenceId: "cancellation-flow"
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
                  "charterId": {
                    "referenceId": "cancellation-flow",
                    "appId": "support-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CHARTER"
                  },
                  "name": "Cancellation Flow",
                  "manual": "Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding.",
                  "childCharterIds": [],
                  "references": {
                    "knowledgeBases": [],
                    "actionIds": []
                  },
                  "precondition": {
                    "preconditionType": "conversation",
                    "value": {
                      "conversationPreconditionType": "tags",
                      "tags": [
                        "cancellation"
                      ]
                    }
                  },
                  "status": "ACTIVE",
                  "type": "STANDARD",
                  "userRank": 0,
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-01-15T12:30:00Z"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CharterResponse(
            charterId: EntityId(
                referenceId: "cancellation-flow",
                appId: "support-app",
                organizationId: "acme",
                agentId: "support",
                type: .charter
            ),
            name: "Cancellation Flow",
            manual: Optional("Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding."),
            childCharterIds: [],
            references: CharterReferences(
                knowledgeBases: Optional([]),
                actionIds: []
            ),
            precondition: Optional(.tags(
                .init(
                    tags: []
                )
            )),
            status: .active,
            type: Optional(.standard),
            userRank: 0,
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
        )
        let response = try await client.charters.get(
            charterReferenceId: "cancellation-flow",
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
                  "charterId": {
                    "referenceId": "cancellation-flow",
                    "appId": "support-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CHARTER"
                  },
                  "name": "Cancellation Flow",
                  "manual": "Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding.",
                  "childCharterIds": [],
                  "references": {
                    "knowledgeBases": [],
                    "actionIds": []
                  },
                  "precondition": {
                    "preconditionType": "conversation",
                    "value": {
                      "conversationPreconditionType": "tags",
                      "tags": [
                        "cancellation"
                      ]
                    }
                  },
                  "status": "ACTIVE",
                  "type": "STANDARD",
                  "userRank": 0,
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-01-15T12:30:00Z"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CharterResponse(
            charterId: EntityId(
                referenceId: "cancellation-flow",
                appId: "support-app",
                organizationId: "acme",
                agentId: "support",
                type: .charter
            ),
            name: "Cancellation Flow",
            manual: Optional("Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding."),
            childCharterIds: [],
            references: CharterReferences(
                knowledgeBases: Optional([]),
                actionIds: []
            ),
            precondition: Optional(.tags(
                .init(
                    tags: []
                )
            )),
            status: .active,
            type: Optional(.standard),
            userRank: 0,
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
        )
        let response = try await client.charters.patch(
            charterReferenceId: "cancellation-flow",
            request: .init(
                precondition: .value(Precondition.conversation(
                    .init(
                        conversation: 
                    )
                )),
                status: .active
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func delete1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "charterId": {
                    "referenceId": "cancellation-flow",
                    "appId": "support-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CHARTER"
                  },
                  "name": "Cancellation Flow",
                  "manual": "Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding.",
                  "childCharterIds": [],
                  "references": {
                    "knowledgeBases": [],
                    "actionIds": []
                  },
                  "precondition": {
                    "preconditionType": "conversation",
                    "value": {
                      "conversationPreconditionType": "tags",
                      "tags": [
                        "cancellation"
                      ]
                    }
                  },
                  "status": "ACTIVE",
                  "type": "STANDARD",
                  "userRank": 0,
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-01-15T12:30:00Z"
                }
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            token: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CharterResponse(
            charterId: EntityId(
                referenceId: "cancellation-flow",
                appId: "support-app",
                organizationId: "acme",
                agentId: "support",
                type: .charter
            ),
            name: "Cancellation Flow",
            manual: Optional("Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding."),
            childCharterIds: [],
            references: CharterReferences(
                knowledgeBases: Optional([]),
                actionIds: []
            ),
            precondition: Optional(.tags(
                .init(
                    tags: []
                )
            )),
            status: .active,
            type: Optional(.standard),
            userRank: 0,
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
        )
        let response = try await client.charters.delete(
            charterReferenceId: "cancellation-flow",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "number": 0,
                  "size": 20,
                  "totalElements": 1,
                  "totalPages": 1,
                  "charters": [
                    {
                      "charterId": {
                        "referenceId": "cancellation-flow",
                        "appId": "support-app",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CHARTER"
                      },
                      "name": "Cancellation Flow",
                      "precondition": {
                        "preconditionType": "conversation",
                        "value": {
                          "conversationPreconditionType": "tags",
                          "tags": [
                            "cancellation"
                          ]
                        }
                      },
                      "parentCharterId": null,
                      "status": "ACTIVE",
                      "type": "STANDARD",
                      "childrenExclusionPolicy": "DEFAULT",
                      "createdAt": "2025-01-01T00:00:00Z",
                      "updatedAt": "2025-01-15T12:30:00Z"
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
        let expectedResponse = CharterSearchResponse(
            number: 0,
            size: 20,
            totalElements: 1,
            totalPages: 1,
            charters: [
                CharterSummary(
                    charterId: EntityId(
                        referenceId: "cancellation-flow",
                        appId: "support-app",
                        organizationId: "acme",
                        agentId: "support",
                        type: .charter
                    ),
                    name: "Cancellation Flow",
                    precondition: Nullable<PreconditionResponse>.value(.tags(
                        .init(
                            tags: []
                        )
                    )),
                    status: .active,
                    type: Optional(.standard),
                    childrenExclusionPolicy: Optional(.default),
                    createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
                )
            ]
        )
        let response = try await client.charters.search(
            request: CharterSearchRequest(
                page: 0,
                size: 20
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getAncestors1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "charters": [
                    {
                      "charterId": {
                        "referenceId": "cancellation-flow",
                        "appId": "support-app",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CHARTER"
                      },
                      "name": "Cancellation Flow",
                      "childCharterIds": [
                        {
                          "referenceId": "cancellation-step-1",
                          "appId": "support-app",
                          "organizationId": "acme",
                          "agentId": "support",
                          "type": "CHARTER"
                        }
                      ],
                      "status": "ACTIVE",
                      "type": "STANDARD",
                      "userRank": 0,
                      "references": {
                        "knowledgeBases": [
                          {
                            "knowledgeBaseId": {
                              "referenceId": "cancellation-policy",
                              "appId": "support-app",
                              "organizationId": "acme",
                              "agentId": "support",
                              "type": "KNOWLEDGE_BASE"
                            }
                          }
                        ],
                        "actionIds": []
                      },
                      "createdAt": "2025-01-01T00:00:00Z",
                      "updatedAt": "2025-01-15T12:30:00Z"
                    },
                    {
                      "charterId": {
                        "referenceId": "cancellation-step-1",
                        "appId": "support-app",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CHARTER"
                      },
                      "name": "Cancellation Step 1",
                      "parentCharterId": {
                        "referenceId": "cancellation-flow",
                        "appId": "support-app",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CHARTER"
                      },
                      "childCharterIds": [],
                      "precondition": {
                        "preconditionType": "user",
                        "key": "plan",
                        "value": "premium"
                      },
                      "status": "ACTIVE",
                      "type": "STANDARD",
                      "userRank": 0,
                      "references": {
                        "knowledgeBases": [],
                        "actionIds": [
                          {
                            "referenceId": "cancel-subscription",
                            "appId": "support-app",
                            "organizationId": "acme",
                            "agentId": "support",
                            "type": "ACTION"
                          }
                        ]
                      },
                      "createdAt": "2025-01-02T00:00:00Z",
                      "updatedAt": "2025-01-16T12:30:00Z"
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
        let expectedResponse = CharterAncestorsResponse(
            charters: [
                CharterResponse(
                    charterId: EntityId(
                        referenceId: "cancellation-flow",
                        appId: "support-app",
                        organizationId: "acme",
                        agentId: "support",
                        type: .charter
                    ),
                    name: "Cancellation Flow",
                    childCharterIds: [
                        EntityId(
                            referenceId: "cancellation-step-1",
                            appId: "support-app",
                            organizationId: "acme",
                            agentId: "support",
                            type: .charter
                        )
                    ],
                    status: .active,
                    type: Optional(.standard),
                    userRank: 0,
                    references: CharterReferences(
                        knowledgeBases: Optional([
                            CharterKnowledgeBaseReference(
                                knowledgeBaseId: EntityId(
                                    referenceId: "cancellation-policy",
                                    appId: "support-app",
                                    organizationId: "acme",
                                    agentId: "support",
                                    type: .knowledgeBase
                                )
                            )
                        ]),
                        actionIds: []
                    ),
                    createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
                ),
                CharterResponse(
                    charterId: EntityId(
                        referenceId: "cancellation-step-1",
                        appId: "support-app",
                        organizationId: "acme",
                        agentId: "support",
                        type: .charter
                    ),
                    name: "Cancellation Step 1",
                    parentCharterId: Optional(EntityId(
                        referenceId: "cancellation-flow",
                        appId: "support-app",
                        organizationId: "acme",
                        agentId: "support",
                        type: .charter
                    )),
                    childCharterIds: [],
                    precondition: Optional(.user(
                        .init(
                            key: "plan",
                            value: Optional("premium")
                        )
                    )),
                    status: .active,
                    type: Optional(.standard),
                    userRank: 0,
                    references: CharterReferences(
                        knowledgeBases: Optional([]),
                        actionIds: []
                    ),
                    createdAt: try! Date("2025-01-02T00:00:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2025-01-16T12:30:00Z", strategy: .iso8601)
                )
            ]
        )
        let response = try await client.charters.getAncestors(
            charterReferenceId: "cancellation-step-1",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func listChildren1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "number": 0,
                  "size": 500,
                  "totalElements": 1,
                  "totalPages": 1,
                  "results": [
                    {
                      "hasMore": false,
                      "children": [
                        {
                          "charterId": {
                            "referenceId": "cancellation-flow",
                            "appId": "support-app",
                            "organizationId": "acme",
                            "agentId": "support",
                            "type": "CHARTER"
                          },
                          "name": "Cancellation Flow",
                          "manual": "Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding.",
                          "childCharterIds": [
                            {
                              "referenceId": "cancellation-step-1",
                              "appId": "support-app",
                              "organizationId": "acme",
                              "agentId": "support",
                              "type": "CHARTER"
                            }
                          ],
                          "references": {
                            "knowledgeBases": [],
                            "actionIds": []
                          },
                          "precondition": {
                            "preconditionType": "conversation",
                            "value": {
                              "conversationPreconditionType": "tags",
                              "tags": [
                                "cancellation"
                              ]
                            }
                          },
                          "status": "ACTIVE",
                          "type": "STANDARD",
                          "userRank": 0,
                          "createdAt": "2025-01-01T00:00:00Z",
                          "updatedAt": "2025-01-15T12:30:00Z"
                        }
                      ]
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
        let expectedResponse = CharterListChildrenResponse(
            number: 0,
            size: 500,
            totalElements: 1,
            totalPages: 1,
            results: [
                CharterChildrenGroup(
                    hasMore: false,
                    children: [
                        CharterResponse(
                            charterId: EntityId(
                                referenceId: "cancellation-flow",
                                appId: "support-app",
                                organizationId: "acme",
                                agentId: "support",
                                type: .charter
                            ),
                            name: "Cancellation Flow",
                            manual: Optional("Guide the user through the cancellation process with empathy. Always confirm their intent before proceeding."),
                            childCharterIds: [
                                EntityId(
                                    referenceId: "cancellation-step-1",
                                    appId: "support-app",
                                    organizationId: "acme",
                                    agentId: "support",
                                    type: .charter
                                )
                            ],
                            references: CharterReferences(
                                knowledgeBases: Optional([]),
                                actionIds: []
                            ),
                            precondition: Optional(.tags(
                                .init(
                                    tags: []
                                )
                            )),
                            status: .active,
                            type: Optional(.standard),
                            userRank: 0,
                            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
                            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601)
                        )
                    ]
                )
            ]
        )
        let response = try await client.charters.listChildren(
            request: CharterListChildrenRequest(
                parentIds: []
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}