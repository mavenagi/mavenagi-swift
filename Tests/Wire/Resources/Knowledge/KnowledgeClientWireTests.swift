import Foundation
import Testing
import Api

@Suite("KnowledgeClient Wire Tests") struct KnowledgeClientWireTests {
    @Test func searchKnowledgeBases1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "knowledgeBases": [
                    {
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "knowledgeBaseId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "activeVersionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "mostRecentVersionStatus": "SUCCEEDED",
                      "type": "API",
                      "metadata": {
                        "metadata": "metadata"
                      },
                      "tags": [
                        "tags"
                      ],
                      "llmInclusionStatus": "ALWAYS",
                      "refreshFrequency": "NONE",
                      "segmentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "segmentIds": [
                        {
                          "organizationId": "organizationId",
                          "agentId": "agentId",
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        }
                      ],
                      "url": "url",
                      "name": "name",
                      "precondition": {
                        "preconditionType": "user",
                        "key": "key",
                        "value": "value",
                        "values": [
                          "values",
                          "values"
                        ],
                        "operator": "NOT"
                      }
                    },
                    {
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "knowledgeBaseId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "activeVersionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "mostRecentVersionStatus": "SUCCEEDED",
                      "type": "API",
                      "metadata": {
                        "metadata": "metadata"
                      },
                      "tags": [
                        "tags"
                      ],
                      "llmInclusionStatus": "ALWAYS",
                      "refreshFrequency": "NONE",
                      "segmentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "segmentIds": [
                        {
                          "organizationId": "organizationId",
                          "agentId": "agentId",
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        }
                      ],
                      "url": "url",
                      "name": "name",
                      "precondition": {
                        "preconditionType": "user",
                        "key": "key",
                        "value": "value",
                        "values": [
                          "values",
                          "values"
                        ],
                        "operator": "NOT"
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
        let expectedResponse = KnowledgeBasesResponse(
            knowledgeBases: [
                KnowledgeBaseResponse(
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    knowledgeBaseId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    activeVersionId: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    mostRecentVersionStatus: .succeeded,
                    type: .api,
                    metadata: [
                        "metadata": "metadata"
                    ],
                    tags: [],
                    llmInclusionStatus: .always,
                    refreshFrequency: .none,
                    segmentId: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    segmentIds: [],
                    url: Optional("url"),
                    name: "name",
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
                    ))
                ),
                KnowledgeBaseResponse(
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    knowledgeBaseId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    activeVersionId: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    mostRecentVersionStatus: .succeeded,
                    type: .api,
                    metadata: [
                        "metadata": "metadata"
                    ],
                    tags: [],
                    llmInclusionStatus: .always,
                    refreshFrequency: .none,
                    segmentId: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    segmentIds: [],
                    url: Optional("url"),
                    name: "name",
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
                    ))
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.knowledge.searchKnowledgeBases(
            request: KnowledgeBaseSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createOrUpdateKnowledgeBase1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-02-02T00:00:00Z",
                  "knowledgeBaseId": {
                    "referenceId": "help-center",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE"
                  },
                  "activeVersionId": {
                    "referenceId": "version-1",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE_VERSION"
                  },
                  "mostRecentVersionStatus": "SUCCEEDED",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "name": "Help center",
                  "type": "API",
                  "metadata": {
                    "key": "value"
                  },
                  "tags": [
                    "tag1",
                    "tag2"
                  ],
                  "refreshFrequency": "DAILY",
                  "segmentIds": [
                    {
                      "referenceId": "premium-users1",
                      "appId": "readme",
                      "organizationId": "acme",
                      "agentId": "support",
                      "type": "SEGMENT"
                    },
                    {
                      "referenceId": "premium-users2",
                      "appId": "readme",
                      "organizationId": "acme",
                      "agentId": "support",
                      "type": "SEGMENT"
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
        let expectedResponse = KnowledgeBaseResponse(
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-02-02T00:00:00Z", strategy: .iso8601),
            knowledgeBaseId: EntityId(
                referenceId: "help-center",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBase
            ),
            activeVersionId: Optional(EntityId(
                referenceId: "version-1",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBaseVersion
            )),
            mostRecentVersionStatus: .succeeded,
            llmInclusionStatus: .whenRelevant,
            name: "Help center",
            type: .api,
            metadata: [
                "key": "value"
            ],
            tags: [],
            refreshFrequency: .daily,
            segmentIds: []
        )
        let response = try await client.knowledge.createOrUpdateKnowledgeBase(
            request: KnowledgeBaseRequest(
                name: "Help center",
                knowledgeBaseId: EntityIdBase(
                    referenceId: "help-center"
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getKnowledgeBase1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-02-02T00:00:00Z",
                  "knowledgeBaseId": {
                    "referenceId": "help-center",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE"
                  },
                  "activeVersionId": {
                    "referenceId": "version-1",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE_VERSION"
                  },
                  "mostRecentVersionStatus": "SUCCEEDED",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "name": "Help center",
                  "type": "API",
                  "metadata": {
                    "key": "value"
                  },
                  "tags": [
                    "tag1",
                    "tag2"
                  ],
                  "refreshFrequency": "DAILY",
                  "segmentIds": [
                    {
                      "referenceId": "premium-users1",
                      "appId": "readme",
                      "organizationId": "acme",
                      "agentId": "support",
                      "type": "SEGMENT"
                    },
                    {
                      "referenceId": "premium-users2",
                      "appId": "readme",
                      "organizationId": "acme",
                      "agentId": "support",
                      "type": "SEGMENT"
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
        let expectedResponse = KnowledgeBaseResponse(
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-02-02T00:00:00Z", strategy: .iso8601),
            knowledgeBaseId: EntityId(
                referenceId: "help-center",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBase
            ),
            activeVersionId: Optional(EntityId(
                referenceId: "version-1",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBaseVersion
            )),
            mostRecentVersionStatus: .succeeded,
            llmInclusionStatus: .whenRelevant,
            name: "Help center",
            type: .api,
            metadata: [
                "key": "value"
            ],
            tags: [],
            refreshFrequency: .daily,
            segmentIds: []
        )
        let response = try await client.knowledge.getKnowledgeBase(
            knowledgeBaseReferenceId: "help-center",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func patchKnowledgeBase1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-02-02T00:00:00Z",
                  "knowledgeBaseId": {
                    "referenceId": "help-center",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE"
                  },
                  "activeVersionId": {
                    "referenceId": "version-1",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE_VERSION"
                  },
                  "mostRecentVersionStatus": "SUCCEEDED",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "name": "Help center",
                  "type": "API",
                  "metadata": {
                    "key": "value"
                  },
                  "tags": [
                    "tag1",
                    "tag2"
                  ],
                  "refreshFrequency": "DAILY",
                  "segmentIds": [
                    {
                      "referenceId": "premium-users1",
                      "appId": "readme",
                      "organizationId": "acme",
                      "agentId": "support",
                      "type": "SEGMENT"
                    },
                    {
                      "referenceId": "premium-users2",
                      "appId": "readme",
                      "organizationId": "acme",
                      "agentId": "support",
                      "type": "SEGMENT"
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
        let expectedResponse = KnowledgeBaseResponse(
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-02-02T00:00:00Z", strategy: .iso8601),
            knowledgeBaseId: EntityId(
                referenceId: "help-center",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBase
            ),
            activeVersionId: Optional(EntityId(
                referenceId: "version-1",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBaseVersion
            )),
            mostRecentVersionStatus: .succeeded,
            llmInclusionStatus: .whenRelevant,
            name: "Help center",
            type: .api,
            metadata: [
                "key": "value"
            ],
            tags: [],
            refreshFrequency: .daily,
            segmentIds: []
        )
        let response = try await client.knowledge.patchKnowledgeBase(
            knowledgeBaseReferenceId: "help-center",
            request: .init(
                name: "Updated Help Center",
                segmentId: .value(EntityId(
                    type: .segment,
                    appId: "readme",
                    referenceId: "premium-users",
                    organizationId: "acme",
                    agentId: "support"
                ))
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createKnowledgeBaseVersion1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "versionId": {
                    "type": "KNOWLEDGE_BASE_VERSION",
                    "referenceId": "versionId",
                    "appId": "maven",
                    "organizationId": "acme",
                    "agentId": "support"
                  },
                  "type": "FULL",
                  "status": "IN_PROGRESS",
                  "createdAt": "2024-01-01T00:00:00Z",
                  "updatedAt": "2024-02-02T00:00:00Z"
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
        let expectedResponse = KnowledgeBaseVersion(
            versionId: EntityId(
                type: .knowledgeBaseVersion,
                referenceId: "versionId",
                appId: "maven",
                organizationId: "acme",
                agentId: "support"
            ),
            type: .full,
            status: .inProgress,
            createdAt: try! Date("2024-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-02-02T00:00:00Z", strategy: .iso8601)
        )
        let response = try await client.knowledge.createKnowledgeBaseVersion(
            knowledgeBaseReferenceId: "help-center",
            request: KnowledgeBaseVersionRequest(
                type: .full
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func finalizeKnowledgeBaseVersion1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "versionId": {
                    "type": "KNOWLEDGE_BASE_VERSION",
                    "referenceId": "versionId",
                    "appId": "maven",
                    "organizationId": "acme",
                    "agentId": "support"
                  },
                  "type": "FULL",
                  "status": "IN_PROGRESS",
                  "createdAt": "2024-01-01T00:00:00Z",
                  "updatedAt": "2024-02-02T00:00:00Z"
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
        let expectedResponse = KnowledgeBaseVersion(
            versionId: EntityId(
                type: .knowledgeBaseVersion,
                referenceId: "versionId",
                appId: "maven",
                organizationId: "acme",
                agentId: "support"
            ),
            type: .full,
            status: .inProgress,
            createdAt: try! Date("2024-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-02-02T00:00:00Z", strategy: .iso8601)
        )
        let response = try await client.knowledge.finalizeKnowledgeBaseVersion(
            knowledgeBaseReferenceId: "help-center",
            request: FinalizeKnowledgeBaseVersionRequest(
                versionId: EntityIdWithoutAgent(
                    type: .knowledgeBaseVersion,
                    appId: "maven",
                    referenceId: "versionId"
                ),
                status: .succeeded
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func listKnowledgeBaseVersions1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "knowledgeBaseVersions": [
                    {
                      "versionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "status": "SUCCEEDED",
                      "errorMessage": "errorMessage",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "type": "FULL"
                    },
                    {
                      "versionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "status": "SUCCEEDED",
                      "errorMessage": "errorMessage",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "type": "FULL"
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
        let expectedResponse = KnowledgeBaseVersionsListResponse(
            knowledgeBaseVersions: [
                KnowledgeBaseVersion(
                    versionId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    status: .succeeded,
                    errorMessage: Optional("errorMessage"),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    type: .full
                ),
                KnowledgeBaseVersion(
                    versionId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    status: .succeeded,
                    errorMessage: Optional("errorMessage"),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    type: .full
                )
            ]
        )
        let response = try await client.knowledge.listKnowledgeBaseVersions(
            knowledgeBaseReferenceId: "knowledgeBaseReferenceId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func searchKnowledgeDocuments1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "knowledgeDocuments": [
                    {
                      "knowledgeDocumentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "knowledgeBaseVersionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "knowledgeBaseId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "title": "title",
                      "llmInclusionStatus": "ALWAYS",
                      "knowledgeBaseLlmInclusionStatus": "ALWAYS",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "url": "url",
                      "language": "language",
                      "author": "author"
                    },
                    {
                      "knowledgeDocumentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "knowledgeBaseVersionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "knowledgeBaseId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "title": "title",
                      "llmInclusionStatus": "ALWAYS",
                      "knowledgeBaseLlmInclusionStatus": "ALWAYS",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "url": "url",
                      "language": "language",
                      "author": "author"
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
        let expectedResponse = KnowledgeDocumentsResponse(
            knowledgeDocuments: [
                KnowledgeDocumentSearchResponse(
                    knowledgeDocumentId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    knowledgeBaseVersionId: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    knowledgeBaseId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    title: Optional("title"),
                    llmInclusionStatus: .always,
                    knowledgeBaseLlmInclusionStatus: .always,
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    url: Optional("url"),
                    language: Optional("language"),
                    author: Optional("author")
                ),
                KnowledgeDocumentSearchResponse(
                    knowledgeDocumentId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    knowledgeBaseVersionId: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    knowledgeBaseId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    title: Optional("title"),
                    llmInclusionStatus: .always,
                    knowledgeBaseLlmInclusionStatus: .always,
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    url: Optional("url"),
                    language: Optional("language"),
                    author: Optional("author")
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.knowledge.searchKnowledgeDocuments(
            request: KnowledgeDocumentSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createKnowledgeDocument1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "knowledgeDocumentId": {
                    "referenceId": "getting-started",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_DOCUMENT"
                  },
                  "knowledgeBaseVersionId": {
                    "referenceId": "versionId",
                    "appId": "maven",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE_VERSION"
                  },
                  "knowledgeBaseId": {
                    "referenceId": "help-docs",
                    "appId": "help-center",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE"
                  },
                  "content": "## Getting started This is a getting started guide for the help center.",
                  "title": "Getting started",
                  "metadata": {
                    "category": "getting-started"
                  },
                  "createdAt": "2024-01-01T00:00:00Z",
                  "updatedAt": "2024-02-02T00:00:00Z",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "relevantEntities": [
                    {
                      "entityId": {
                        "type": "CUSTOMER",
                        "appId": "crm",
                        "organizationId": "acme",
                        "agentId": "support",
                        "referenceId": "customer-42"
                      },
                      "scopeEntityId": {
                        "type": "AGENT",
                        "appId": "maven",
                        "organizationId": "acme",
                        "agentId": "support",
                        "referenceId": "support"
                      }
                    }
                  ],
                  "knowledgeBaseLlmInclusionStatus": "WHEN_RELEVANT"
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
        let expectedResponse = KnowledgeDocumentResponse(
            knowledgeDocumentId: EntityId(
                referenceId: "getting-started",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeDocument
            ),
            knowledgeBaseVersionId: Optional(EntityId(
                referenceId: "versionId",
                appId: "maven",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBaseVersion
            )),
            knowledgeBaseId: EntityId(
                referenceId: "help-docs",
                appId: "help-center",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBase
            ),
            content: "## Getting started This is a getting started guide for the help center.",
            title: Optional("Getting started"),
            metadata: [
                "category": "getting-started"
            ],
            createdAt: try! Date("2024-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-02-02T00:00:00Z", strategy: .iso8601),
            llmInclusionStatus: .whenRelevant,
            relevantEntities: [],
            knowledgeBaseLlmInclusionStatus: .whenRelevant
        )
        let response = try await client.knowledge.createKnowledgeDocument(
            knowledgeBaseReferenceId: "help-center",
            request: KnowledgeDocumentRequest(
                knowledgeDocumentId: EntityIdBase(
                    referenceId: "getting-started"
                ),
                versionId: EntityIdWithoutAgent(
                    type: .knowledgeBaseVersion,
                    appId: "maven",
                    referenceId: "versionId"
                ),
                contentType: .markdown,
                title: "Getting started",
                content: "## Getting started\nThis is a getting started guide for the help center.",
                metadata: [
                    "category": "getting-started"
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getKnowledgeDocument1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "processingStatus": "SUCCEEDED",
                  "content": "content",
                  "asset": {
                    "url": "url",
                    "sizeBytes": 1000000,
                    "status": "PENDING",
                    "type": "type",
                    "name": "name"
                  },
                  "metadata": {
                    "metadata": "metadata"
                  },
                  "relevantEntities": [
                    {
                      "entityId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "scopeEntityId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    }
                  ],
                  "knowledgeDocumentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "knowledgeBaseVersionId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "knowledgeBaseId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "title": "title",
                  "llmInclusionStatus": "ALWAYS",
                  "knowledgeBaseLlmInclusionStatus": "ALWAYS",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "url": "url",
                  "language": "language",
                  "author": "author"
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
        let expectedResponse = KnowledgeDocumentResponse(
            processingStatus: Optional(.succeeded),
            content: "content",
            asset: Optional(AttachmentResponse(
                url: Optional("url"),
                sizeBytes: Optional(1000000),
                status: .pending,
                type: "type",
                name: Optional("name")
            )),
            metadata: [
                "metadata": "metadata"
            ],
            relevantEntities: [],
            knowledgeDocumentId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            knowledgeBaseVersionId: Optional(EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            )),
            knowledgeBaseId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            title: Optional("title"),
            llmInclusionStatus: .always,
            knowledgeBaseLlmInclusionStatus: .always,
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            url: Optional("url"),
            language: Optional("language"),
            author: Optional("author")
        )
        let response = try await client.knowledge.getKnowledgeDocument(
            knowledgeBaseVersionReferenceId: "knowledgeBaseVersionReferenceId",
            knowledgeDocumentReferenceId: "knowledgeDocumentReferenceId",
            knowledgeBaseVersionAppId: "knowledgeBaseVersionAppId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func patchKnowledgeDocument1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "knowledgeDocumentId": {
                    "referenceId": "getting-started",
                    "appId": "readme",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_DOCUMENT"
                  },
                  "knowledgeBaseVersionId": {
                    "referenceId": "versionId",
                    "appId": "maven",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE_VERSION"
                  },
                  "knowledgeBaseId": {
                    "referenceId": "help-docs",
                    "appId": "help-center",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "KNOWLEDGE_BASE"
                  },
                  "content": "## Getting started This is a getting started guide for the help center.",
                  "title": "Getting started",
                  "metadata": {
                    "category": "getting-started"
                  },
                  "createdAt": "2024-01-01T00:00:00Z",
                  "updatedAt": "2024-02-02T00:00:00Z",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "relevantEntities": [
                    {
                      "entityId": {
                        "type": "CUSTOMER",
                        "appId": "crm",
                        "organizationId": "acme",
                        "agentId": "support",
                        "referenceId": "customer-42"
                      },
                      "scopeEntityId": {
                        "type": "AGENT",
                        "appId": "maven",
                        "organizationId": "acme",
                        "agentId": "support",
                        "referenceId": "support"
                      }
                    }
                  ],
                  "knowledgeBaseLlmInclusionStatus": "WHEN_RELEVANT"
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
        let expectedResponse = KnowledgeDocumentResponse(
            knowledgeDocumentId: EntityId(
                referenceId: "getting-started",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeDocument
            ),
            knowledgeBaseVersionId: Optional(EntityId(
                referenceId: "versionId",
                appId: "maven",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBaseVersion
            )),
            knowledgeBaseId: EntityId(
                referenceId: "help-docs",
                appId: "help-center",
                organizationId: "acme",
                agentId: "support",
                type: .knowledgeBase
            ),
            content: "## Getting started This is a getting started guide for the help center.",
            title: Optional("Getting started"),
            metadata: [
                "category": "getting-started"
            ],
            createdAt: try! Date("2024-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-02-02T00:00:00Z", strategy: .iso8601),
            llmInclusionStatus: .whenRelevant,
            relevantEntities: [],
            knowledgeBaseLlmInclusionStatus: .whenRelevant
        )
        let response = try await client.knowledge.patchKnowledgeDocument(
            knowledgeBaseReferenceId: "help-center",
            knowledgeDocumentReferenceId: "how-it-works",
            request: .init(llmInclusionStatus: .always),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}