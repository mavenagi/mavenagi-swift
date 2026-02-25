import Foundation
import Testing
import Api

@Suite("InboxClient Wire Tests") struct InboxClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "items": [
                    {
                      "type": "duplicateDocuments",
                      "recommendedFixes": [
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        },
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        }
                      ],
                      "otherFixes": [
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        },
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        }
                      ],
                      "sourceDocument": {
                        "knowledgeBaseId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "documentId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "title": "title",
                        "snippet": "snippet"
                      },
                      "documents": [
                        {
                          "knowledgeBaseId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "documentId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "title": "title",
                          "snippet": "snippet"
                        },
                        {
                          "knowledgeBaseId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "documentId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "title": "title",
                          "snippet": "snippet"
                        }
                      ],
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "status": "OPEN",
                      "severity": "LOW",
                      "tags": [
                        "tags"
                      ]
                    },
                    {
                      "type": "duplicateDocuments",
                      "recommendedFixes": [
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        },
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        }
                      ],
                      "otherFixes": [
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        },
                        {
                          "documentInformation": {
                            "knowledgeBaseId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "documentId": {
                              "type": "AGENT",
                              "appId": "appId",
                              "referenceId": "x"
                            },
                            "title": "title",
                            "snippet": "snippet"
                          },
                          "id": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        }
                      ],
                      "sourceDocument": {
                        "knowledgeBaseId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "documentId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "title": "title",
                        "snippet": "snippet"
                      },
                      "documents": [
                        {
                          "knowledgeBaseId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "documentId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "title": "title",
                          "snippet": "snippet"
                        },
                        {
                          "knowledgeBaseId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "documentId": {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "title": "title",
                          "snippet": "snippet"
                        }
                      ],
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "status": "OPEN",
                      "severity": "LOW",
                      "tags": [
                        "tags"
                      ]
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
        let expectedResponse = InboxSearchResponse(
            items: [
                .duplicateDocuments(
                    .init(
                        recommendedFixes: [
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            ),
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            )
                        ],
                        otherFixes: [
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            ),
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            )
                        ],
                        sourceDocument: DocumentInformation(
                            knowledgeBaseId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            documentId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            title: Optional("title"),
                            snippet: Optional("snippet")
                        ),
                        documents: [
                            DocumentInformation(
                                knowledgeBaseId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                documentId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                title: Optional("title"),
                                snippet: Optional("snippet")
                            ),
                            DocumentInformation(
                                knowledgeBaseId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                documentId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                title: Optional("title"),
                                snippet: Optional("snippet")
                            )
                        ],
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                        updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                        status: .open,
                        severity: .low,
                        tags: Optional([])
                    )
                ),
                .duplicateDocuments(
                    .init(
                        recommendedFixes: [
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            ),
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            )
                        ],
                        otherFixes: [
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            ),
                            InboxItemFixDeactivateDocument(
                                documentInformation: DocumentInformation(
                                    knowledgeBaseId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    documentId: EntityIdWithoutAgent(
                                        type: .agent,
                                        appId: "appId",
                                        referenceId: "x"
                                    ),
                                    title: Optional("title"),
                                    snippet: Optional("snippet")
                                ),
                                id: EntityId(
                                    organizationId: "organizationId",
                                    agentId: "agentId",
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                )
                            )
                        ],
                        sourceDocument: DocumentInformation(
                            knowledgeBaseId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            documentId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            title: Optional("title"),
                            snippet: Optional("snippet")
                        ),
                        documents: [
                            DocumentInformation(
                                knowledgeBaseId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                documentId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                title: Optional("title"),
                                snippet: Optional("snippet")
                            ),
                            DocumentInformation(
                                knowledgeBaseId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                documentId: EntityIdWithoutAgent(
                                    type: .agent,
                                    appId: "appId",
                                    referenceId: "x"
                                ),
                                title: Optional("title"),
                                snippet: Optional("snippet")
                            )
                        ],
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                        updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                        status: .open,
                        severity: .low,
                        tags: Optional([])
                    )
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.inbox.search(
            request: InboxSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func applyTags1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "type": "custom",
                  "id": {
                    "referenceId": "todo-item-1",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "INBOX_ITEM"
                  },
                  "status": "OPEN",
                  "severity": "HIGH",
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-02-01T00:00:00Z",
                  "metadata": {
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
        let expectedResponse = .custom(
            .init(
                id: EntityId(
                    referenceId: "todo-item-1",
                    appId: "myapp",
                    organizationId: "acme",
                    agentId: "support",
                    type: .inboxItem
                ),
                status: .open,
                severity: .high,
                createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
                updatedAt: try! Date("2025-02-01T00:00:00Z", strategy: .iso8601),
                metadata: [
                    "key": "value"
                ]
            )
        )
        let response = try await client.inbox.applyTags(
            inboxItemId: "custom-item-1",
            request: .init(),
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
                  "type": "duplicateDocuments",
                  "recommendedFixes": [
                    {
                      "documentInformation": {
                        "knowledgeBaseId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "documentId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "title": "title",
                        "snippet": "snippet"
                      },
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    },
                    {
                      "documentInformation": {
                        "knowledgeBaseId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "documentId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "title": "title",
                        "snippet": "snippet"
                      },
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    }
                  ],
                  "otherFixes": [
                    {
                      "documentInformation": {
                        "knowledgeBaseId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "documentId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "title": "title",
                        "snippet": "snippet"
                      },
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    },
                    {
                      "documentInformation": {
                        "knowledgeBaseId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "documentId": {
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "title": "title",
                        "snippet": "snippet"
                      },
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    }
                  ],
                  "sourceDocument": {
                    "knowledgeBaseId": {
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "documentId": {
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "title": "title",
                    "snippet": "snippet"
                  },
                  "documents": [
                    {
                      "knowledgeBaseId": {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "documentId": {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "title": "title",
                      "snippet": "snippet"
                    },
                    {
                      "knowledgeBaseId": {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "documentId": {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "title": "title",
                      "snippet": "snippet"
                    }
                  ],
                  "id": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "status": "OPEN",
                  "severity": "LOW",
                  "tags": [
                    "tags"
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
        let expectedResponse = .duplicateDocuments(
            .init(
                recommendedFixes: [
                    InboxItemFixDeactivateDocument(
                        documentInformation: DocumentInformation(
                            knowledgeBaseId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            documentId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            title: Optional("title"),
                            snippet: Optional("snippet")
                        ),
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        )
                    ),
                    InboxItemFixDeactivateDocument(
                        documentInformation: DocumentInformation(
                            knowledgeBaseId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            documentId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            title: Optional("title"),
                            snippet: Optional("snippet")
                        ),
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        )
                    )
                ],
                otherFixes: [
                    InboxItemFixDeactivateDocument(
                        documentInformation: DocumentInformation(
                            knowledgeBaseId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            documentId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            title: Optional("title"),
                            snippet: Optional("snippet")
                        ),
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        )
                    ),
                    InboxItemFixDeactivateDocument(
                        documentInformation: DocumentInformation(
                            knowledgeBaseId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            documentId: EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            title: Optional("title"),
                            snippet: Optional("snippet")
                        ),
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        )
                    )
                ],
                sourceDocument: DocumentInformation(
                    knowledgeBaseId: EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    documentId: EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    title: Optional("title"),
                    snippet: Optional("snippet")
                ),
                documents: [
                    DocumentInformation(
                        knowledgeBaseId: EntityIdWithoutAgent(
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        documentId: EntityIdWithoutAgent(
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        title: Optional("title"),
                        snippet: Optional("snippet")
                    ),
                    DocumentInformation(
                        knowledgeBaseId: EntityIdWithoutAgent(
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        documentId: EntityIdWithoutAgent(
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        title: Optional("title"),
                        snippet: Optional("snippet")
                    )
                ],
                id: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                status: .open,
                severity: .low,
                tags: Optional([])
            )
        )
        let response = try await client.inbox.get(
            inboxItemId: "inboxItemId",
            appId: "appId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getFix1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "type": "addDocument",
                  "suggestedTextTitle": "suggestedTextTitle",
                  "suggestedText": "suggestedText",
                  "id": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
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
        let expectedResponse = .addDocument(
            .init(
                suggestedTextTitle: "suggestedTextTitle",
                suggestedText: "suggestedText",
                id: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                )
            )
        )
        let response = try await client.inbox.getFix(
            inboxItemFixId: "inboxItemFixId",
            appId: "appId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}