import Foundation
import Testing
import Api

@Suite("ConversationClient Wire Tests") struct ConversationClientWireTests {
    @Test func initialize1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "messages": [
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "attachments": [
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    },
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    }
                  ],
                  "responseConfig": {
                    "capabilities": [
                      "MARKDOWN",
                      "MARKDOWN"
                    ],
                    "isCopilot": true,
                    "responseLength": "SHORT",
                    "contextFilter": {
                      "scopeType": "byEntities",
                      "entities": [
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
                      ]
                    }
                  },
                  "subject": "subject",
                  "url": "url",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "tags": [
                    "tags"
                  ],
                  "metadata": {
                    "metadata": "metadata"
                  },
                  "allMetadata": {
                    "allMetadata": {
                      "allMetadata": "allMetadata"
                    }
                  },
                  "conversationId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "analysis": {
                    "userRequest": "userRequest",
                    "agentResponse": "agentResponse",
                    "resolutionStatus": "resolutionStatus",
                    "category": "category",
                    "sentiment": "POSITIVE",
                    "quality": "GOOD",
                    "qualityReason": "MISSING_KNOWLEDGE",
                    "resolvedByMaven": true,
                    "primaryLanguage": "primaryLanguage",
                    "predictedNps": 1.1,
                    "csat": 1.1
                  },
                  "summary": {
                    "actionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "incompleteActionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "insertCount": 1,
                    "thumbsUpCount": 1,
                    "thumbsDownCount": 1,
                    "handoffCount": 1,
                    "userMessageCount": 1,
                    "botMessageCount": 1,
                    "csat": 1.1,
                    "handleTime": 1000000,
                    "humanAgentResponseDelay": 1000000,
                    "humanAgents": [
                      "humanAgents",
                      "humanAgents"
                    ],
                    "humanAgentsWithInserts": [
                      "humanAgentsWithInserts",
                      "humanAgentsWithInserts"
                    ],
                    "users": [
                      "users",
                      "users"
                    ],
                    "userIdentifiers": [
                      "userIdentifiers",
                      "userIdentifiers"
                    ],
                    "lastUserMessage": "lastUserMessage",
                    "lastBotMessage": "lastBotMessage",
                    "involvedAppIds": [
                      "involvedAppIds"
                    ]
                  },
                  "deleted": true,
                  "open": true,
                  "llmEnabled": true,
                  "simulationContext": {
                    "additionalPromptText": "additionalPromptText",
                    "persona": "CASUAL_BUDDY",
                    "availableKnowledgeBases": [
                      {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ]
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
        let expectedResponse = ConversationResponse(
            messages: [
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                ),
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                )
            ],
            attachments: [
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                ),
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                )
            ],
            responseConfig: Optional(ResponseConfig(
                capabilities: [
                    .markdown,
                    .markdown
                ],
                isCopilot: true,
                responseLength: .short,
                contextFilter: Optional(.byEntities(
                    .init(
                        entities: []
                    )
                ))
            )),
            subject: Optional("subject"),
            url: Optional("url"),
            createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            tags: Optional([]),
            metadata: Optional([
                "metadata": "metadata"
            ]),
            allMetadata: [
                "allMetadata": [
                    "allMetadata": "allMetadata"
                ]
            ],
            conversationId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            analysis: ConversationAnalysis(
                userRequest: Optional("userRequest"),
                agentResponse: Optional("agentResponse"),
                resolutionStatus: Optional("resolutionStatus"),
                category: Optional("category"),
                sentiment: Optional(.positive),
                quality: Optional(.good),
                qualityReason: Optional(.missingKnowledge),
                resolvedByMaven: Optional(true),
                primaryLanguage: Optional("primaryLanguage"),
                predictedNps: Optional(1.1),
                csat: Optional(1.1)
            ),
            summary: ConversationSummary(
                actionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                incompleteActionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                insertCount: 1,
                thumbsUpCount: 1,
                thumbsDownCount: 1,
                handoffCount: 1,
                userMessageCount: 1,
                botMessageCount: 1,
                csat: Optional(1.1),
                handleTime: Optional(1000000),
                humanAgentResponseDelay: Optional(1000000),
                humanAgents: [
                    "humanAgents",
                    "humanAgents"
                ],
                humanAgentsWithInserts: [
                    "humanAgentsWithInserts",
                    "humanAgentsWithInserts"
                ],
                users: [
                    "users",
                    "users"
                ],
                userIdentifiers: [
                    "userIdentifiers",
                    "userIdentifiers"
                ],
                lastUserMessage: Optional("lastUserMessage"),
                lastBotMessage: Optional("lastBotMessage"),
                involvedAppIds: []
            ),
            deleted: true,
            open: true,
            llmEnabled: true,
            simulationContext: Optional(SimulationContext(
                additionalPromptText: Optional("additionalPromptText"),
                persona: Optional(.casualBuddy),
                availableKnowledgeBases: Optional([])
            ))
        )
        let response = try await client.conversation.initialize(
            request: ConversationRequest(
                conversationId: EntityIdBase(
                    referenceId: "x"
                ),
                messages: [
                    ConversationMessageRequest(
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        conversationMessageId: EntityIdBase(
                            referenceId: "x"
                        )
                    ),
                    ConversationMessageRequest(
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        conversationMessageId: EntityIdBase(
                            referenceId: "x"
                        )
                    )
                ]
            ),
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
                  "conversationId": {
                    "referenceId": "conversation-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CONVERSATION"
                  },
                  "deleted": false,
                  "open": false,
                  "llmEnabled": true,
                  "analysis": {
                    "resolutionStatus": "Resolved",
                    "sentiment": "POSITIVE",
                    "resolvedByMaven": true
                  },
                  "summary": {
                    "actionIds": [],
                    "incompleteActionIds": [],
                    "insertCount": 0,
                    "thumbsUpCount": 0,
                    "thumbsDownCount": 0,
                    "handoffCount": 0,
                    "userMessageCount": 1,
                    "botMessageCount": 1,
                    "humanAgents": [],
                    "humanAgentsWithInserts": [],
                    "users": [],
                    "userIdentifiers": [],
                    "involvedAppIds": [
                      "myapp"
                    ]
                  },
                  "metadata": {},
                  "allMetadata": {},
                  "attachments": [],
                  "messages": [
                    {
                      "type": "user",
                      "userMessageType": "USER",
                      "conversationMessageId": {
                        "referenceId": "message-0",
                        "appId": "myapp",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION_MESSAGE"
                      },
                      "status": "UNKNOWN",
                      "userId": {
                        "referenceId": "user-0"
                      },
                      "text": "How do I reset my password?",
                      "attachments": [
                        {
                          "url": "https://example.com/attachment-0",
                          "type": "image/png",
                          "status": "ACCEPTED",
                          "sizeBytes": 1234
                        }
                      ]
                    },
                    {
                      "type": "bot",
                      "botMessageType": "BOT_RESPONSE",
                      "conversationMessageId": {
                        "referenceId": "message-1",
                        "appId": "myapp",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION_MESSAGE"
                      },
                      "status": "SENT",
                      "responses": [
                        {
                          "type": "text",
                          "text": "Hi! Go to acme.com/reset-password"
                        }
                      ],
                      "metadata": {
                        "followupQuestions": [
                          "What if I did not get the reset email?"
                        ],
                        "sources": []
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
        let expectedResponse = ConversationResponse(
            conversationId: EntityId(
                referenceId: "conversation-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .conversation
            ),
            deleted: false,
            open: false,
            llmEnabled: true,
            analysis: ConversationAnalysis(
                resolutionStatus: Optional("Resolved"),
                sentiment: Optional(.positive),
                resolvedByMaven: Optional(true)
            ),
            summary: ConversationSummary(
                actionIds: [],
                incompleteActionIds: [],
                insertCount: 0,
                thumbsUpCount: 0,
                thumbsDownCount: 0,
                handoffCount: 0,
                userMessageCount: 1,
                botMessageCount: 1,
                humanAgents: [],
                humanAgentsWithInserts: [],
                users: [],
                userIdentifiers: [],
                involvedAppIds: []
            ),
            metadata: Optional([:]),
            allMetadata: [:],
            attachments: [],
            messages: [
                .user(
                    .init(
                        userMessageType: .user,
                        conversationMessageId: EntityId(
                            referenceId: "message-0",
                            appId: "myapp",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversationMessage
                        ),
                        status: .unknown,
                        userId: EntityIdBase(
                            referenceId: "user-0"
                        ),
                        text: "How do I reset my password?",
                        attachments: [
                            AttachmentResponse(
                                url: Optional("https://example.com/attachment-0"),
                                type: "image/png",
                                status: .accepted,
                                sizeBytes: Optional(1234)
                            )
                        ]
                    )
                ),
                .bot(
                    .init(
                        botMessageType: .botResponse,
                        conversationMessageId: EntityId(
                            referenceId: "message-1",
                            appId: "myapp",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversationMessage
                        ),
                        status: .sent,
                        responses: [
                            .text(
                                .init(
                                    text: "Hi! Go to acme.com/reset-password"
                                )
                            )
                        ],
                        metadata: BotResponseMetadata(
                            followupQuestions: [
                                "What if I did not get the reset email?"
                            ],
                            sources: []
                        )
                    )
                )
            ]
        )
        let response = try await client.conversation.patch(
            conversationId: "conversation-0",
            request: ConversationPatchRequest(
                llmEnabled: true
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
                  "messages": [
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "attachments": [
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    },
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    }
                  ],
                  "responseConfig": {
                    "capabilities": [
                      "MARKDOWN",
                      "MARKDOWN"
                    ],
                    "isCopilot": true,
                    "responseLength": "SHORT",
                    "contextFilter": {
                      "scopeType": "byEntities",
                      "entities": [
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
                      ]
                    }
                  },
                  "subject": "subject",
                  "url": "url",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "tags": [
                    "tags"
                  ],
                  "metadata": {
                    "metadata": "metadata"
                  },
                  "allMetadata": {
                    "allMetadata": {
                      "allMetadata": "allMetadata"
                    }
                  },
                  "conversationId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "analysis": {
                    "userRequest": "userRequest",
                    "agentResponse": "agentResponse",
                    "resolutionStatus": "resolutionStatus",
                    "category": "category",
                    "sentiment": "POSITIVE",
                    "quality": "GOOD",
                    "qualityReason": "MISSING_KNOWLEDGE",
                    "resolvedByMaven": true,
                    "primaryLanguage": "primaryLanguage",
                    "predictedNps": 1.1,
                    "csat": 1.1
                  },
                  "summary": {
                    "actionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "incompleteActionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "insertCount": 1,
                    "thumbsUpCount": 1,
                    "thumbsDownCount": 1,
                    "handoffCount": 1,
                    "userMessageCount": 1,
                    "botMessageCount": 1,
                    "csat": 1.1,
                    "handleTime": 1000000,
                    "humanAgentResponseDelay": 1000000,
                    "humanAgents": [
                      "humanAgents",
                      "humanAgents"
                    ],
                    "humanAgentsWithInserts": [
                      "humanAgentsWithInserts",
                      "humanAgentsWithInserts"
                    ],
                    "users": [
                      "users",
                      "users"
                    ],
                    "userIdentifiers": [
                      "userIdentifiers",
                      "userIdentifiers"
                    ],
                    "lastUserMessage": "lastUserMessage",
                    "lastBotMessage": "lastBotMessage",
                    "involvedAppIds": [
                      "involvedAppIds"
                    ]
                  },
                  "deleted": true,
                  "open": true,
                  "llmEnabled": true,
                  "simulationContext": {
                    "additionalPromptText": "additionalPromptText",
                    "persona": "CASUAL_BUDDY",
                    "availableKnowledgeBases": [
                      {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ]
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
        let expectedResponse = ConversationResponse(
            messages: [
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                ),
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                )
            ],
            attachments: [
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                ),
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                )
            ],
            responseConfig: Optional(ResponseConfig(
                capabilities: [
                    .markdown,
                    .markdown
                ],
                isCopilot: true,
                responseLength: .short,
                contextFilter: Optional(.byEntities(
                    .init(
                        entities: []
                    )
                ))
            )),
            subject: Optional("subject"),
            url: Optional("url"),
            createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            tags: Optional([]),
            metadata: Optional([
                "metadata": "metadata"
            ]),
            allMetadata: [
                "allMetadata": [
                    "allMetadata": "allMetadata"
                ]
            ],
            conversationId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            analysis: ConversationAnalysis(
                userRequest: Optional("userRequest"),
                agentResponse: Optional("agentResponse"),
                resolutionStatus: Optional("resolutionStatus"),
                category: Optional("category"),
                sentiment: Optional(.positive),
                quality: Optional(.good),
                qualityReason: Optional(.missingKnowledge),
                resolvedByMaven: Optional(true),
                primaryLanguage: Optional("primaryLanguage"),
                predictedNps: Optional(1.1),
                csat: Optional(1.1)
            ),
            summary: ConversationSummary(
                actionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                incompleteActionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                insertCount: 1,
                thumbsUpCount: 1,
                thumbsDownCount: 1,
                handoffCount: 1,
                userMessageCount: 1,
                botMessageCount: 1,
                csat: Optional(1.1),
                handleTime: Optional(1000000),
                humanAgentResponseDelay: Optional(1000000),
                humanAgents: [
                    "humanAgents",
                    "humanAgents"
                ],
                humanAgentsWithInserts: [
                    "humanAgentsWithInserts",
                    "humanAgentsWithInserts"
                ],
                users: [
                    "users",
                    "users"
                ],
                userIdentifiers: [
                    "userIdentifiers",
                    "userIdentifiers"
                ],
                lastUserMessage: Optional("lastUserMessage"),
                lastBotMessage: Optional("lastBotMessage"),
                involvedAppIds: []
            ),
            deleted: true,
            open: true,
            llmEnabled: true,
            simulationContext: Optional(SimulationContext(
                additionalPromptText: Optional("additionalPromptText"),
                persona: Optional(.casualBuddy),
                availableKnowledgeBases: Optional([])
            ))
        )
        let response = try await client.conversation.get(
            conversationId: "conversationId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func appendNewMessages1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "messages": [
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "attachments": [
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    },
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    }
                  ],
                  "responseConfig": {
                    "capabilities": [
                      "MARKDOWN",
                      "MARKDOWN"
                    ],
                    "isCopilot": true,
                    "responseLength": "SHORT",
                    "contextFilter": {
                      "scopeType": "byEntities",
                      "entities": [
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
                      ]
                    }
                  },
                  "subject": "subject",
                  "url": "url",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "tags": [
                    "tags"
                  ],
                  "metadata": {
                    "metadata": "metadata"
                  },
                  "allMetadata": {
                    "allMetadata": {
                      "allMetadata": "allMetadata"
                    }
                  },
                  "conversationId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "analysis": {
                    "userRequest": "userRequest",
                    "agentResponse": "agentResponse",
                    "resolutionStatus": "resolutionStatus",
                    "category": "category",
                    "sentiment": "POSITIVE",
                    "quality": "GOOD",
                    "qualityReason": "MISSING_KNOWLEDGE",
                    "resolvedByMaven": true,
                    "primaryLanguage": "primaryLanguage",
                    "predictedNps": 1.1,
                    "csat": 1.1
                  },
                  "summary": {
                    "actionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "incompleteActionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "insertCount": 1,
                    "thumbsUpCount": 1,
                    "thumbsDownCount": 1,
                    "handoffCount": 1,
                    "userMessageCount": 1,
                    "botMessageCount": 1,
                    "csat": 1.1,
                    "handleTime": 1000000,
                    "humanAgentResponseDelay": 1000000,
                    "humanAgents": [
                      "humanAgents",
                      "humanAgents"
                    ],
                    "humanAgentsWithInserts": [
                      "humanAgentsWithInserts",
                      "humanAgentsWithInserts"
                    ],
                    "users": [
                      "users",
                      "users"
                    ],
                    "userIdentifiers": [
                      "userIdentifiers",
                      "userIdentifiers"
                    ],
                    "lastUserMessage": "lastUserMessage",
                    "lastBotMessage": "lastBotMessage",
                    "involvedAppIds": [
                      "involvedAppIds"
                    ]
                  },
                  "deleted": true,
                  "open": true,
                  "llmEnabled": true,
                  "simulationContext": {
                    "additionalPromptText": "additionalPromptText",
                    "persona": "CASUAL_BUDDY",
                    "availableKnowledgeBases": [
                      {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ]
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
        let expectedResponse = ConversationResponse(
            messages: [
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                ),
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                )
            ],
            attachments: [
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                ),
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                )
            ],
            responseConfig: Optional(ResponseConfig(
                capabilities: [
                    .markdown,
                    .markdown
                ],
                isCopilot: true,
                responseLength: .short,
                contextFilter: Optional(.byEntities(
                    .init(
                        entities: []
                    )
                ))
            )),
            subject: Optional("subject"),
            url: Optional("url"),
            createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            tags: Optional([]),
            metadata: Optional([
                "metadata": "metadata"
            ]),
            allMetadata: [
                "allMetadata": [
                    "allMetadata": "allMetadata"
                ]
            ],
            conversationId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            analysis: ConversationAnalysis(
                userRequest: Optional("userRequest"),
                agentResponse: Optional("agentResponse"),
                resolutionStatus: Optional("resolutionStatus"),
                category: Optional("category"),
                sentiment: Optional(.positive),
                quality: Optional(.good),
                qualityReason: Optional(.missingKnowledge),
                resolvedByMaven: Optional(true),
                primaryLanguage: Optional("primaryLanguage"),
                predictedNps: Optional(1.1),
                csat: Optional(1.1)
            ),
            summary: ConversationSummary(
                actionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                incompleteActionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                insertCount: 1,
                thumbsUpCount: 1,
                thumbsDownCount: 1,
                handoffCount: 1,
                userMessageCount: 1,
                botMessageCount: 1,
                csat: Optional(1.1),
                handleTime: Optional(1000000),
                humanAgentResponseDelay: Optional(1000000),
                humanAgents: [
                    "humanAgents",
                    "humanAgents"
                ],
                humanAgentsWithInserts: [
                    "humanAgentsWithInserts",
                    "humanAgentsWithInserts"
                ],
                users: [
                    "users",
                    "users"
                ],
                userIdentifiers: [
                    "userIdentifiers",
                    "userIdentifiers"
                ],
                lastUserMessage: Optional("lastUserMessage"),
                lastBotMessage: Optional("lastBotMessage"),
                involvedAppIds: []
            ),
            deleted: true,
            open: true,
            llmEnabled: true,
            simulationContext: Optional(SimulationContext(
                additionalPromptText: Optional("additionalPromptText"),
                persona: Optional(.casualBuddy),
                availableKnowledgeBases: Optional([])
            ))
        )
        let response = try await client.conversation.appendNewMessages(
            conversationId: "conversationId",
            request: [
                ConversationMessageRequest(
                    userId: EntityIdBase(
                        referenceId: "x"
                    ),
                    text: "text",
                    userMessageType: .user,
                    conversationMessageId: EntityIdBase(
                        referenceId: "x"
                    )
                ),
                ConversationMessageRequest(
                    userId: EntityIdBase(
                        referenceId: "x"
                    ),
                    text: "text",
                    userMessageType: .user,
                    conversationMessageId: EntityIdBase(
                        referenceId: "x"
                    )
                )
            ],
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func ask1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "conversationId": {
                    "referenceId": "conversation-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CONVERSATION"
                  },
                  "deleted": false,
                  "open": false,
                  "llmEnabled": true,
                  "analysis": {
                    "resolutionStatus": "Resolved",
                    "sentiment": "POSITIVE",
                    "resolvedByMaven": true
                  },
                  "summary": {
                    "actionIds": [],
                    "incompleteActionIds": [],
                    "insertCount": 0,
                    "thumbsUpCount": 0,
                    "thumbsDownCount": 0,
                    "handoffCount": 0,
                    "userMessageCount": 1,
                    "botMessageCount": 1,
                    "humanAgents": [],
                    "humanAgentsWithInserts": [],
                    "users": [],
                    "userIdentifiers": [],
                    "involvedAppIds": [
                      "myapp"
                    ]
                  },
                  "metadata": {},
                  "allMetadata": {},
                  "attachments": [],
                  "messages": [
                    {
                      "type": "user",
                      "userMessageType": "USER",
                      "conversationMessageId": {
                        "referenceId": "message-0",
                        "appId": "myapp",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION_MESSAGE"
                      },
                      "status": "UNKNOWN",
                      "userId": {
                        "referenceId": "user-0"
                      },
                      "text": "How do I reset my password?",
                      "attachments": [
                        {
                          "url": "https://example.com/attachment-0",
                          "type": "image/png",
                          "status": "ACCEPTED",
                          "sizeBytes": 1234
                        }
                      ]
                    },
                    {
                      "type": "bot",
                      "botMessageType": "BOT_RESPONSE",
                      "conversationMessageId": {
                        "referenceId": "message-1",
                        "appId": "myapp",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION_MESSAGE"
                      },
                      "status": "SENT",
                      "responses": [
                        {
                          "type": "text",
                          "text": "Hi! Go to acme.com/reset-password"
                        }
                      ],
                      "metadata": {
                        "followupQuestions": [
                          "What if I did not get the reset email?"
                        ],
                        "sources": []
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
        let expectedResponse = ConversationResponse(
            conversationId: EntityId(
                referenceId: "conversation-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .conversation
            ),
            deleted: false,
            open: false,
            llmEnabled: true,
            analysis: ConversationAnalysis(
                resolutionStatus: Optional("Resolved"),
                sentiment: Optional(.positive),
                resolvedByMaven: Optional(true)
            ),
            summary: ConversationSummary(
                actionIds: [],
                incompleteActionIds: [],
                insertCount: 0,
                thumbsUpCount: 0,
                thumbsDownCount: 0,
                handoffCount: 0,
                userMessageCount: 1,
                botMessageCount: 1,
                humanAgents: [],
                humanAgentsWithInserts: [],
                users: [],
                userIdentifiers: [],
                involvedAppIds: []
            ),
            metadata: Optional([:]),
            allMetadata: [:],
            attachments: [],
            messages: [
                .user(
                    .init(
                        userMessageType: .user,
                        conversationMessageId: EntityId(
                            referenceId: "message-0",
                            appId: "myapp",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversationMessage
                        ),
                        status: .unknown,
                        userId: EntityIdBase(
                            referenceId: "user-0"
                        ),
                        text: "How do I reset my password?",
                        attachments: [
                            AttachmentResponse(
                                url: Optional("https://example.com/attachment-0"),
                                type: "image/png",
                                status: .accepted,
                                sizeBytes: Optional(1234)
                            )
                        ]
                    )
                ),
                .bot(
                    .init(
                        botMessageType: .botResponse,
                        conversationMessageId: EntityId(
                            referenceId: "message-1",
                            appId: "myapp",
                            organizationId: "acme",
                            agentId: "support",
                            type: .conversationMessage
                        ),
                        status: .sent,
                        responses: [
                            .text(
                                .init(
                                    text: "Hi! Go to acme.com/reset-password"
                                )
                            )
                        ],
                        metadata: BotResponseMetadata(
                            followupQuestions: [
                                "What if I did not get the reset email?"
                            ],
                            sources: []
                        )
                    )
                )
            ]
        )
        let response = try await client.conversation.ask(
            conversationId: "conversation-0",
            request: AskRequest(
                conversationMessageId: EntityIdBase(
                    referenceId: "message-0"
                ),
                userId: EntityIdBase(
                    referenceId: "user-0"
                ),
                text: "How do I reset my password?",
                attachments: [
                    AttachmentRequest(
                        type: "image/png",
                        content: "iVBORw0KGgo..."
                    )
                ],
                transientData: [
                    "userToken": "abcdef123", 
                    "queryApiKey": "foobar456"
                ],
                timezone: "America/New_York"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func categorize1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "category": "category"
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
        let expectedResponse = CategorizationResponse(
            category: Optional("category")
        )
        let response = try await client.conversation.categorize(
            conversationId: "conversationId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createFeedback1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "feedbackId": {
                    "referenceId": "feedback-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "FEEDBACK"
                  },
                  "conversationId": {
                    "referenceId": "conversation-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CONVERSATION"
                  },
                  "conversationMessageId": {
                    "referenceId": "message-1",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CONVERSATION_MESSAGE"
                  },
                  "userId": {
                    "referenceId": "user-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "USER"
                  },
                  "type": "THUMBS_UP",
                  "text": "Great answer!"
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
        let expectedResponse = Feedback(
            feedbackId: EntityId(
                referenceId: "feedback-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .feedback
            ),
            conversationId: EntityId(
                referenceId: "conversation-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .conversation
            ),
            conversationMessageId: EntityId(
                referenceId: "message-1",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .conversationMessage
            ),
            userId: Optional(EntityId(
                referenceId: "user-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .user
            )),
            type: .thumbsUp,
            text: Optional("Great answer!")
        )
        let response = try await client.conversation.createFeedback(
            request: FeedbackRequest(
                type: .thumbsUp,
                text: "Great answer!",
                feedbackId: EntityIdBase(
                    referenceId: "feedback-0"
                ),
                conversationId: EntityIdBase(
                    referenceId: "conversation-0"
                ),
                conversationMessageId: EntityIdBase(
                    referenceId: "message-1"
                ),
                userId: EntityIdBase(
                    referenceId: "user-0"
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func submitActionForm1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "messages": [
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "type": "user",
                      "conversationMessageId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "language": "language",
                      "attachments": [
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        },
                        {
                          "url": "url",
                          "sizeBytes": 1000000,
                          "status": "PENDING",
                          "type": "type",
                          "name": "name"
                        }
                      ],
                      "agentUserId": "agentUserId",
                      "userDisplayName": "userDisplayName",
                      "status": "SENDING",
                      "responseState": "NOT_ASKED",
                      "userId": {
                        "referenceId": "x"
                      },
                      "text": "text",
                      "userMessageType": "USER",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "attachments": [
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    },
                    {
                      "url": "url",
                      "sizeBytes": 1000000,
                      "status": "PENDING",
                      "type": "type",
                      "name": "name"
                    }
                  ],
                  "responseConfig": {
                    "capabilities": [
                      "MARKDOWN",
                      "MARKDOWN"
                    ],
                    "isCopilot": true,
                    "responseLength": "SHORT",
                    "contextFilter": {
                      "scopeType": "byEntities",
                      "entities": [
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
                      ]
                    }
                  },
                  "subject": "subject",
                  "url": "url",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "tags": [
                    "tags"
                  ],
                  "metadata": {
                    "metadata": "metadata"
                  },
                  "allMetadata": {
                    "allMetadata": {
                      "allMetadata": "allMetadata"
                    }
                  },
                  "conversationId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "analysis": {
                    "userRequest": "userRequest",
                    "agentResponse": "agentResponse",
                    "resolutionStatus": "resolutionStatus",
                    "category": "category",
                    "sentiment": "POSITIVE",
                    "quality": "GOOD",
                    "qualityReason": "MISSING_KNOWLEDGE",
                    "resolvedByMaven": true,
                    "primaryLanguage": "primaryLanguage",
                    "predictedNps": 1.1,
                    "csat": 1.1
                  },
                  "summary": {
                    "actionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "incompleteActionIds": [
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      {
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ],
                    "insertCount": 1,
                    "thumbsUpCount": 1,
                    "thumbsDownCount": 1,
                    "handoffCount": 1,
                    "userMessageCount": 1,
                    "botMessageCount": 1,
                    "csat": 1.1,
                    "handleTime": 1000000,
                    "humanAgentResponseDelay": 1000000,
                    "humanAgents": [
                      "humanAgents",
                      "humanAgents"
                    ],
                    "humanAgentsWithInserts": [
                      "humanAgentsWithInserts",
                      "humanAgentsWithInserts"
                    ],
                    "users": [
                      "users",
                      "users"
                    ],
                    "userIdentifiers": [
                      "userIdentifiers",
                      "userIdentifiers"
                    ],
                    "lastUserMessage": "lastUserMessage",
                    "lastBotMessage": "lastBotMessage",
                    "involvedAppIds": [
                      "involvedAppIds"
                    ]
                  },
                  "deleted": true,
                  "open": true,
                  "llmEnabled": true,
                  "simulationContext": {
                    "additionalPromptText": "additionalPromptText",
                    "persona": "CASUAL_BUDDY",
                    "availableKnowledgeBases": [
                      {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      }
                    ]
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
        let expectedResponse = ConversationResponse(
            messages: [
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                ),
                .user(
                    .init(
                        conversationMessageId: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        language: Optional("language"),
                        attachments: [
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            ),
                            AttachmentResponse(
                                url: Optional("url"),
                                sizeBytes: Optional(1000000),
                                status: .pending,
                                type: "type",
                                name: Optional("name")
                            )
                        ],
                        agentUserId: Optional("agentUserId"),
                        userDisplayName: Optional("userDisplayName"),
                        status: .sending,
                        responseState: Optional(.notAsked),
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601))
                    )
                )
            ],
            attachments: [
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                ),
                AttachmentResponse(
                    url: Optional("url"),
                    sizeBytes: Optional(1000000),
                    status: .pending,
                    type: "type",
                    name: Optional("name")
                )
            ],
            responseConfig: Optional(ResponseConfig(
                capabilities: [
                    .markdown,
                    .markdown
                ],
                isCopilot: true,
                responseLength: .short,
                contextFilter: Optional(.byEntities(
                    .init(
                        entities: []
                    )
                ))
            )),
            subject: Optional("subject"),
            url: Optional("url"),
            createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
            tags: Optional([]),
            metadata: Optional([
                "metadata": "metadata"
            ]),
            allMetadata: [
                "allMetadata": [
                    "allMetadata": "allMetadata"
                ]
            ],
            conversationId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            analysis: ConversationAnalysis(
                userRequest: Optional("userRequest"),
                agentResponse: Optional("agentResponse"),
                resolutionStatus: Optional("resolutionStatus"),
                category: Optional("category"),
                sentiment: Optional(.positive),
                quality: Optional(.good),
                qualityReason: Optional(.missingKnowledge),
                resolvedByMaven: Optional(true),
                primaryLanguage: Optional("primaryLanguage"),
                predictedNps: Optional(1.1),
                csat: Optional(1.1)
            ),
            summary: ConversationSummary(
                actionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                incompleteActionIds: [
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )
                ],
                insertCount: 1,
                thumbsUpCount: 1,
                thumbsDownCount: 1,
                handoffCount: 1,
                userMessageCount: 1,
                botMessageCount: 1,
                csat: Optional(1.1),
                handleTime: Optional(1000000),
                humanAgentResponseDelay: Optional(1000000),
                humanAgents: [
                    "humanAgents",
                    "humanAgents"
                ],
                humanAgentsWithInserts: [
                    "humanAgentsWithInserts",
                    "humanAgentsWithInserts"
                ],
                users: [
                    "users",
                    "users"
                ],
                userIdentifiers: [
                    "userIdentifiers",
                    "userIdentifiers"
                ],
                lastUserMessage: Optional("lastUserMessage"),
                lastBotMessage: Optional("lastBotMessage"),
                involvedAppIds: []
            ),
            deleted: true,
            open: true,
            llmEnabled: true,
            simulationContext: Optional(SimulationContext(
                additionalPromptText: Optional("additionalPromptText"),
                persona: Optional(.casualBuddy),
                availableKnowledgeBases: Optional([])
            ))
        )
        let response = try await client.conversation.submitActionForm(
            conversationId: "conversationId",
            request: SubmitActionFormRequest(
                actionFormId: "actionFormId",
                parameters: [
                    "parameters": ActionFormRequestParamValue.jsonValue(
                        .object([
                            "key": .string("value")
                        ])
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func addConversationMetadata1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "string": "string"
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
            "string": "string"
        ]
        let response = try await client.conversation.addConversationMetadata(
            conversationId: "conversationId",
            request: [
                "string": "string"
            ],
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func updateConversationMetadata1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "metadata": {
                    "myapp": {
                      "key": "newValue"
                    },
                    "conversation-owning-app": {
                      "existingKey": "existingValue"
                    }
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
        let expectedResponse = ConversationMetadata(
            metadata: [
                "myapp": [
                    "key": "newValue"
                ], 
                "conversation-owning-app": [
                    "existingKey": "existingValue"
                ]
            ]
        )
        let response = try await client.conversation.updateConversationMetadata(
            conversationId: "conversation-0",
            request: UpdateMetadataRequest(
                appId: "conversation-owning-app",
                values: [
                    "key": "newValue"
                ]
            ),
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
                  "conversations": [
                    {
                      "responseConfig": {
                        "capabilities": [
                          "MARKDOWN",
                          "MARKDOWN"
                        ],
                        "isCopilot": true,
                        "responseLength": "SHORT",
                        "contextFilter": {
                          "scopeType": "byEntities",
                          "entities": [
                            {
                              "entityId": {
                                "organizationId": "organizationId",
                                "agentId": "agentId",
                                "type": "AGENT",
                                "appId": "appId",
                                "referenceId": "x"
                              }
                            }
                          ]
                        }
                      },
                      "subject": "subject",
                      "url": "url",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "tags": [
                        "tags"
                      ],
                      "metadata": {
                        "metadata": "metadata"
                      },
                      "allMetadata": {
                        "allMetadata": {
                          "allMetadata": "allMetadata"
                        }
                      },
                      "conversationId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "analysis": {
                        "userRequest": "userRequest",
                        "agentResponse": "agentResponse",
                        "resolutionStatus": "resolutionStatus",
                        "category": "category",
                        "sentiment": "POSITIVE",
                        "quality": "GOOD",
                        "qualityReason": "MISSING_KNOWLEDGE",
                        "resolvedByMaven": true,
                        "primaryLanguage": "primaryLanguage",
                        "predictedNps": 1.1,
                        "csat": 1.1
                      },
                      "summary": {
                        "actionIds": [
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        ],
                        "incompleteActionIds": [
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        ],
                        "insertCount": 1,
                        "thumbsUpCount": 1,
                        "thumbsDownCount": 1,
                        "handoffCount": 1,
                        "userMessageCount": 1,
                        "botMessageCount": 1,
                        "csat": 1.1,
                        "handleTime": 1000000,
                        "humanAgentResponseDelay": 1000000,
                        "humanAgents": [
                          "humanAgents",
                          "humanAgents"
                        ],
                        "humanAgentsWithInserts": [
                          "humanAgentsWithInserts",
                          "humanAgentsWithInserts"
                        ],
                        "users": [
                          "users",
                          "users"
                        ],
                        "userIdentifiers": [
                          "userIdentifiers",
                          "userIdentifiers"
                        ],
                        "lastUserMessage": "lastUserMessage",
                        "lastBotMessage": "lastBotMessage",
                        "involvedAppIds": [
                          "involvedAppIds"
                        ]
                      },
                      "deleted": true,
                      "open": true,
                      "llmEnabled": true,
                      "simulationContext": {
                        "additionalPromptText": "additionalPromptText",
                        "persona": "CASUAL_BUDDY",
                        "availableKnowledgeBases": [
                          {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        ]
                      }
                    },
                    {
                      "responseConfig": {
                        "capabilities": [
                          "MARKDOWN",
                          "MARKDOWN"
                        ],
                        "isCopilot": true,
                        "responseLength": "SHORT",
                        "contextFilter": {
                          "scopeType": "byEntities",
                          "entities": [
                            {
                              "entityId": {
                                "organizationId": "organizationId",
                                "agentId": "agentId",
                                "type": "AGENT",
                                "appId": "appId",
                                "referenceId": "x"
                              }
                            }
                          ]
                        }
                      },
                      "subject": "subject",
                      "url": "url",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "tags": [
                        "tags"
                      ],
                      "metadata": {
                        "metadata": "metadata"
                      },
                      "allMetadata": {
                        "allMetadata": {
                          "allMetadata": "allMetadata"
                        }
                      },
                      "conversationId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "analysis": {
                        "userRequest": "userRequest",
                        "agentResponse": "agentResponse",
                        "resolutionStatus": "resolutionStatus",
                        "category": "category",
                        "sentiment": "POSITIVE",
                        "quality": "GOOD",
                        "qualityReason": "MISSING_KNOWLEDGE",
                        "resolvedByMaven": true,
                        "primaryLanguage": "primaryLanguage",
                        "predictedNps": 1.1,
                        "csat": 1.1
                      },
                      "summary": {
                        "actionIds": [
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        ],
                        "incompleteActionIds": [
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          {
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        ],
                        "insertCount": 1,
                        "thumbsUpCount": 1,
                        "thumbsDownCount": 1,
                        "handoffCount": 1,
                        "userMessageCount": 1,
                        "botMessageCount": 1,
                        "csat": 1.1,
                        "handleTime": 1000000,
                        "humanAgentResponseDelay": 1000000,
                        "humanAgents": [
                          "humanAgents",
                          "humanAgents"
                        ],
                        "humanAgentsWithInserts": [
                          "humanAgentsWithInserts",
                          "humanAgentsWithInserts"
                        ],
                        "users": [
                          "users",
                          "users"
                        ],
                        "userIdentifiers": [
                          "userIdentifiers",
                          "userIdentifiers"
                        ],
                        "lastUserMessage": "lastUserMessage",
                        "lastBotMessage": "lastBotMessage",
                        "involvedAppIds": [
                          "involvedAppIds"
                        ]
                      },
                      "deleted": true,
                      "open": true,
                      "llmEnabled": true,
                      "simulationContext": {
                        "additionalPromptText": "additionalPromptText",
                        "persona": "CASUAL_BUDDY",
                        "availableKnowledgeBases": [
                          {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          }
                        ]
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
        let expectedResponse = ConversationsResponse(
            conversations: [
                ConversationPreview(
                    responseConfig: Optional(ResponseConfig(
                        capabilities: [
                            .markdown,
                            .markdown
                        ],
                        isCopilot: true,
                        responseLength: .short,
                        contextFilter: Optional(.byEntities(
                            .init(
                                entities: []
                            )
                        ))
                    )),
                    subject: Optional("subject"),
                    url: Optional("url"),
                    createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    tags: Optional([]),
                    metadata: Optional([
                        "metadata": "metadata"
                    ]),
                    allMetadata: [
                        "allMetadata": [
                            "allMetadata": "allMetadata"
                        ]
                    ],
                    conversationId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    analysis: ConversationAnalysis(
                        userRequest: Optional("userRequest"),
                        agentResponse: Optional("agentResponse"),
                        resolutionStatus: Optional("resolutionStatus"),
                        category: Optional("category"),
                        sentiment: Optional(.positive),
                        quality: Optional(.good),
                        qualityReason: Optional(.missingKnowledge),
                        resolvedByMaven: Optional(true),
                        primaryLanguage: Optional("primaryLanguage"),
                        predictedNps: Optional(1.1),
                        csat: Optional(1.1)
                    ),
                    summary: ConversationSummary(
                        actionIds: [
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            )
                        ],
                        incompleteActionIds: [
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            )
                        ],
                        insertCount: 1,
                        thumbsUpCount: 1,
                        thumbsDownCount: 1,
                        handoffCount: 1,
                        userMessageCount: 1,
                        botMessageCount: 1,
                        csat: Optional(1.1),
                        handleTime: Optional(1000000),
                        humanAgentResponseDelay: Optional(1000000),
                        humanAgents: [
                            "humanAgents",
                            "humanAgents"
                        ],
                        humanAgentsWithInserts: [
                            "humanAgentsWithInserts",
                            "humanAgentsWithInserts"
                        ],
                        users: [
                            "users",
                            "users"
                        ],
                        userIdentifiers: [
                            "userIdentifiers",
                            "userIdentifiers"
                        ],
                        lastUserMessage: Optional("lastUserMessage"),
                        lastBotMessage: Optional("lastBotMessage"),
                        involvedAppIds: []
                    ),
                    deleted: true,
                    open: true,
                    llmEnabled: true,
                    simulationContext: Optional(SimulationContext(
                        additionalPromptText: Optional("additionalPromptText"),
                        persona: Optional(.casualBuddy),
                        availableKnowledgeBases: Optional([])
                    ))
                ),
                ConversationPreview(
                    responseConfig: Optional(ResponseConfig(
                        capabilities: [
                            .markdown,
                            .markdown
                        ],
                        isCopilot: true,
                        responseLength: .short,
                        contextFilter: Optional(.byEntities(
                            .init(
                                entities: []
                            )
                        ))
                    )),
                    subject: Optional("subject"),
                    url: Optional("url"),
                    createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    updatedAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    tags: Optional([]),
                    metadata: Optional([
                        "metadata": "metadata"
                    ]),
                    allMetadata: [
                        "allMetadata": [
                            "allMetadata": "allMetadata"
                        ]
                    ],
                    conversationId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    analysis: ConversationAnalysis(
                        userRequest: Optional("userRequest"),
                        agentResponse: Optional("agentResponse"),
                        resolutionStatus: Optional("resolutionStatus"),
                        category: Optional("category"),
                        sentiment: Optional(.positive),
                        quality: Optional(.good),
                        qualityReason: Optional(.missingKnowledge),
                        resolvedByMaven: Optional(true),
                        primaryLanguage: Optional("primaryLanguage"),
                        predictedNps: Optional(1.1),
                        csat: Optional(1.1)
                    ),
                    summary: ConversationSummary(
                        actionIds: [
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            )
                        ],
                        incompleteActionIds: [
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            EntityIdWithoutAgent(
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            )
                        ],
                        insertCount: 1,
                        thumbsUpCount: 1,
                        thumbsDownCount: 1,
                        handoffCount: 1,
                        userMessageCount: 1,
                        botMessageCount: 1,
                        csat: Optional(1.1),
                        handleTime: Optional(1000000),
                        humanAgentResponseDelay: Optional(1000000),
                        humanAgents: [
                            "humanAgents",
                            "humanAgents"
                        ],
                        humanAgentsWithInserts: [
                            "humanAgentsWithInserts",
                            "humanAgentsWithInserts"
                        ],
                        users: [
                            "users",
                            "users"
                        ],
                        userIdentifiers: [
                            "userIdentifiers",
                            "userIdentifiers"
                        ],
                        lastUserMessage: Optional("lastUserMessage"),
                        lastBotMessage: Optional("lastBotMessage"),
                        involvedAppIds: []
                    ),
                    deleted: true,
                    open: true,
                    llmEnabled: true,
                    simulationContext: Optional(SimulationContext(
                        additionalPromptText: Optional("additionalPromptText"),
                        persona: Optional(.casualBuddy),
                        availableKnowledgeBases: Optional([])
                    ))
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.conversation.search(
            request: ConversationsSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func deliverMessage1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "status": "DELIVERED"
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
        let expectedResponse = DeliverMessageResponse(
            status: .delivered
        )
        let response = try await client.conversation.deliverMessage(
            request: DeliverMessageRequest.user(
                .init(
                    userId: EntityIdWithoutAgent(
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    message: ConversationMessageRequest(
                        userId: EntityIdBase(
                            referenceId: "x"
                        ),
                        text: "text",
                        userMessageType: .user,
                        conversationMessageId: EntityIdBase(
                            referenceId: "x"
                        )
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}