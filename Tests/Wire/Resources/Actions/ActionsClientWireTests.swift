import Foundation
import Testing
import Api

@Suite("ActionsClient Wire Tests") struct ActionsClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "actions": [
                    {
                      "actionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
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
                      "name": "name",
                      "description": "description",
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
                      "language": "language"
                    },
                    {
                      "actionId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
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
                      "name": "name",
                      "description": "description",
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
                      "language": "language"
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
        let expectedResponse = ActionsResponse(
            actions: [
                ActionResponse(
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
                    name: "name",
                    description: "description",
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
                    language: Optional("language")
                ),
                ActionResponse(
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
                    name: "name",
                    description: "description",
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
                    language: Optional("language")
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.actions.search(
            request: ActionsSearchRequest(

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
                  "actionId": {
                    "referenceId": "get-balance",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "ACTION"
                  },
                  "name": "Get the user's balance",
                  "description": "This action calls an API to get the user's current balance.",
                  "instructions": "This action calls an API to get the user's current balance.",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "userInteractionRequired": false,
                  "userFormParameters": [],
                  "precondition": {
                    "preconditionType": "group",
                    "operator": "AND",
                    "preconditions": [
                      {
                        "preconditionType": "user",
                        "key": "userKey"
                      },
                      {
                        "preconditionType": "user",
                        "key": "userKey2"
                      }
                    ]
                  },
                  "segmentId": {
                    "referenceId": "premium-users",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "SEGMENT"
                  },
                  "language": "en",
                  "deleted": false
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
        let expectedResponse = ActionResponse(
            actionId: EntityId(
                referenceId: "get-balance",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .action
            ),
            name: "Get the user's balance",
            description: "This action calls an API to get the user's current balance.",
            instructions: Optional("This action calls an API to get the user's current balance."),
            llmInclusionStatus: .whenRelevant,
            userInteractionRequired: false,
            userFormParameters: [],
            precondition: Optional(.group(
                .init(
                    operator: .and,
                    preconditions: [
                        JSONValue.object(
                            [
                                "preconditionType": JSONValue.string("user"), 
                                "key": JSONValue.string("userKey")
                            ]
                        ),
                        JSONValue.object(
                            [
                                "preconditionType": JSONValue.string("user"), 
                                "key": JSONValue.string("userKey2")
                            ]
                        )
                    ]
                )
            )),
            segmentId: Optional(EntityId(
                referenceId: "premium-users",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            )),
            language: Optional("en"),
            deleted: false
        )
        let response = try await client.actions.createOrUpdate(
            request: ActionRequest(
                name: "Get the user's balance",
                description: "This action calls an API to get the user's current balance.",
                userInteractionRequired: false,
                precondition: Precondition.group(
                    .init(
                        operator: .and,
                        preconditions: [
                            Precondition.user(
                                .init(
                                    key: "userKey"
                                )
                            ),
                            Precondition.user(
                                .init(
                                    key: "userKey2"
                                )
                            )
                        ]
                    )
                ),
                userFormParameters: [],
                language: "en",
                actionId: EntityIdBase(
                    referenceId: "get-balance"
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
                  "actionId": {
                    "referenceId": "get-balance",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "ACTION"
                  },
                  "name": "Get the user's balance",
                  "description": "This action calls an API to get the user's current balance.",
                  "instructions": "This action calls an API to get the user's current balance.",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "userInteractionRequired": false,
                  "userFormParameters": [],
                  "precondition": {
                    "preconditionType": "group",
                    "operator": "AND",
                    "preconditions": [
                      {
                        "preconditionType": "user",
                        "key": "userKey"
                      },
                      {
                        "preconditionType": "user",
                        "key": "userKey2"
                      }
                    ]
                  },
                  "segmentId": {
                    "referenceId": "premium-users",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "SEGMENT"
                  },
                  "language": "en",
                  "deleted": false
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
        let expectedResponse = ActionResponse(
            actionId: EntityId(
                referenceId: "get-balance",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .action
            ),
            name: "Get the user's balance",
            description: "This action calls an API to get the user's current balance.",
            instructions: Optional("This action calls an API to get the user's current balance."),
            llmInclusionStatus: .whenRelevant,
            userInteractionRequired: false,
            userFormParameters: [],
            precondition: Optional(.group(
                .init(
                    operator: .and,
                    preconditions: [
                        JSONValue.object(
                            [
                                "preconditionType": JSONValue.string("user"), 
                                "key": JSONValue.string("userKey")
                            ]
                        ),
                        JSONValue.object(
                            [
                                "preconditionType": JSONValue.string("user"), 
                                "key": JSONValue.string("userKey2")
                            ]
                        )
                    ]
                )
            )),
            segmentId: Optional(EntityId(
                referenceId: "premium-users",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            )),
            language: Optional("en"),
            deleted: false
        )
        let response = try await client.actions.get(
            actionReferenceId: "get-balance",
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
                  "actionId": {
                    "referenceId": "get-balance",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "ACTION"
                  },
                  "name": "Get the user's balance",
                  "description": "This action calls an API to get the user's current balance.",
                  "instructions": "This action calls an API to get the user's current balance.",
                  "llmInclusionStatus": "WHEN_RELEVANT",
                  "userInteractionRequired": false,
                  "userFormParameters": [],
                  "precondition": {
                    "preconditionType": "group",
                    "operator": "AND",
                    "preconditions": [
                      {
                        "preconditionType": "user",
                        "key": "userKey"
                      },
                      {
                        "preconditionType": "user",
                        "key": "userKey2"
                      }
                    ]
                  },
                  "segmentId": {
                    "referenceId": "premium-users",
                    "appId": "my-billing-system",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "SEGMENT"
                  },
                  "language": "en",
                  "deleted": false
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
        let expectedResponse = ActionResponse(
            actionId: EntityId(
                referenceId: "get-balance",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .action
            ),
            name: "Get the user's balance",
            description: "This action calls an API to get the user's current balance.",
            instructions: Optional("This action calls an API to get the user's current balance."),
            llmInclusionStatus: .whenRelevant,
            userInteractionRequired: false,
            userFormParameters: [],
            precondition: Optional(.group(
                .init(
                    operator: .and,
                    preconditions: [
                        JSONValue.object(
                            [
                                "preconditionType": JSONValue.string("user"), 
                                "key": JSONValue.string("userKey")
                            ]
                        ),
                        JSONValue.object(
                            [
                                "preconditionType": JSONValue.string("user"), 
                                "key": JSONValue.string("userKey2")
                            ]
                        )
                    ]
                )
            )),
            segmentId: Optional(EntityId(
                referenceId: "premium-users",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            )),
            language: Optional("en"),
            deleted: false
        )
        let response = try await client.actions.patch(
            actionReferenceId: "get-balance",
            request: .init(
                instructions: "Use this action when the user asks about their account balance or remaining credits.",
                llmInclusionStatus: .whenRelevant,
                segmentId: .value(EntityId(
                    type: .segment,
                    appId: "my-billing-system",
                    referenceId: "premium-users",
                    organizationId: "acme",
                    agentId: "support"
                ))
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}