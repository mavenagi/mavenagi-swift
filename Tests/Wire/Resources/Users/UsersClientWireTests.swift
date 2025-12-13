import Foundation
import Testing
import Api

@Suite("UsersClient Wire Tests") struct UsersClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "agentUsers": [
                    {
                      "id": "id",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "identifiers": [
                        {
                          "value": "value",
                          "type": "EMAIL"
                        }
                      ],
                      "defaultName": "defaultName",
                      "users": [
                        {
                          "userId": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "identifiers": [
                            {
                              "value": "value",
                              "type": "EMAIL"
                            }
                          ],
                          "visibleData": {
                            "visibleData": "visibleData"
                          }
                        },
                        {
                          "userId": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "identifiers": [
                            {
                              "value": "value",
                              "type": "EMAIL"
                            }
                          ],
                          "visibleData": {
                            "visibleData": "visibleData"
                          }
                        }
                      ]
                    },
                    {
                      "id": "id",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "identifiers": [
                        {
                          "value": "value",
                          "type": "EMAIL"
                        }
                      ],
                      "defaultName": "defaultName",
                      "users": [
                        {
                          "userId": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "identifiers": [
                            {
                              "value": "value",
                              "type": "EMAIL"
                            }
                          ],
                          "visibleData": {
                            "visibleData": "visibleData"
                          }
                        },
                        {
                          "userId": {
                            "organizationId": "organizationId",
                            "agentId": "agentId",
                            "type": "AGENT",
                            "appId": "appId",
                            "referenceId": "x"
                          },
                          "identifiers": [
                            {
                              "value": "value",
                              "type": "EMAIL"
                            }
                          ],
                          "visibleData": {
                            "visibleData": "visibleData"
                          }
                        }
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
        let expectedResponse = AgentUserSearchResponse(
            agentUsers: [
                AgentUser(
                    id: "id",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    identifiers: [],
                    defaultName: Optional("defaultName"),
                    users: [
                        AppUserSummary(
                            userId: EntityId(
                                organizationId: "organizationId",
                                agentId: "agentId",
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            identifiers: [],
                            visibleData: [
                                "visibleData": "visibleData"
                            ]
                        ),
                        AppUserSummary(
                            userId: EntityId(
                                organizationId: "organizationId",
                                agentId: "agentId",
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            identifiers: [],
                            visibleData: [
                                "visibleData": "visibleData"
                            ]
                        )
                    ]
                ),
                AgentUser(
                    id: "id",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    identifiers: [],
                    defaultName: Optional("defaultName"),
                    users: [
                        AppUserSummary(
                            userId: EntityId(
                                organizationId: "organizationId",
                                agentId: "agentId",
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            identifiers: [],
                            visibleData: [
                                "visibleData": "visibleData"
                            ]
                        ),
                        AppUserSummary(
                            userId: EntityId(
                                organizationId: "organizationId",
                                agentId: "agentId",
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            ),
                            identifiers: [],
                            visibleData: [
                                "visibleData": "visibleData"
                            ]
                        )
                    ]
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.users.search(
            request: AgentUserSearchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getAgentUser1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "id": "aus_1234567890",
                  "createdAt": "2021-01-01T00:00:00Z",
                  "updatedAt": "2021-01-01T00:00:00Z",
                  "identifiers": [
                    {
                      "value": "joe@myapp.com",
                      "type": "EMAIL"
                    }
                  ],
                  "defaultName": "Joe",
                  "users": [
                    {
                      "userId": {
                        "type": "USER_PROFILE",
                        "appId": "myapp",
                        "organizationId": "acme",
                        "agentId": "support",
                        "referenceId": "user-0"
                      },
                      "identifiers": [],
                      "visibleData": {
                        "name": "Joe"
                      }
                    },
                    {
                      "userId": {
                        "type": "USER_PROFILE",
                        "appId": "myapp2",
                        "organizationId": "acme",
                        "agentId": "support",
                        "referenceId": "user-abc"
                      },
                      "identifiers": [
                        {
                          "value": "joe@myapp2.com",
                          "type": "EMAIL"
                        }
                      ],
                      "visibleData": {
                        "name": "Joe Doe"
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
        let expectedResponse = AgentUser(
            id: "aus_1234567890",
            createdAt: try! Date("2021-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2021-01-01T00:00:00Z", strategy: .iso8601),
            identifiers: [],
            defaultName: Optional("Joe"),
            users: [
                AppUserSummary(
                    userId: EntityId(
                        type: .userProfile,
                        appId: "myapp",
                        organizationId: "acme",
                        agentId: "support",
                        referenceId: "user-0"
                    ),
                    identifiers: [],
                    visibleData: [
                        "name": "Joe"
                    ]
                ),
                AppUserSummary(
                    userId: EntityId(
                        type: .userProfile,
                        appId: "myapp2",
                        organizationId: "acme",
                        agentId: "support",
                        referenceId: "user-abc"
                    ),
                    identifiers: [],
                    visibleData: [
                        "name": "Joe Doe"
                    ]
                )
            ]
        )
        let response = try await client.users.getAgentUser(
            agentUserId: "aus_1234567890",
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
                  "userId": {
                    "referenceId": "user-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "USER_PROFILE"
                  },
                  "agentUserId": "aus_1234567890",
                  "identifiers": [
                    {
                      "value": "joe@myapp.com",
                      "type": "EMAIL"
                    }
                  ],
                  "data": {
                    "name": {
                      "value": "Joe",
                      "visibility": "VISIBLE"
                    }
                  },
                  "allUserData": {
                    "myapp": {
                      "name": "Joe"
                    }
                  },
                  "defaultUserData": {
                    "name": "Joe"
                  },
                  "agentUserData": {
                    "name": [
                      {
                        "value": "Joe",
                        "visibility": "VISIBLE",
                        "userId": {
                          "appId": "myapp",
                          "referenceId": "user0"
                        }
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
        let expectedResponse = AppUserResponse(
            userId: EntityId(
                referenceId: "user-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .userProfile
            ),
            agentUserId: "aus_1234567890",
            identifiers: [],
            data: [
                "name": UserData(
                    value: "Joe",
                    visibility: .visible
                )
            ],
            allUserData: [
                "myapp": [
                    "name": "Joe"
                ]
            ],
            defaultUserData: [
                "name": "Joe"
            ],
            agentUserData: [
                "name": [
                    UserDataWithReference(
                        value: "Joe",
                        visibility: .visible,
                        userId: EntityIdFilter(
                            appId: "myapp",
                            referenceId: "user0"
                        )
                    )
                ]
            ]
        )
        let response = try await client.users.createOrUpdate(
            request: AppUserRequest(
                data: [
                    "name": UserData(
                        value: "Joe",
                        visibility: .visible
                    )
                ],
                userId: EntityIdBase(
                    referenceId: "user-0"
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
                  "userId": {
                    "referenceId": "user-0",
                    "appId": "myapp",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "USER_PROFILE"
                  },
                  "agentUserId": "aus_1234567890",
                  "identifiers": [
                    {
                      "value": "joe@myapp.com",
                      "type": "EMAIL"
                    }
                  ],
                  "data": {
                    "name": {
                      "value": "Joe",
                      "visibility": "VISIBLE"
                    }
                  },
                  "allUserData": {
                    "myapp": {
                      "name": "Joe"
                    }
                  },
                  "defaultUserData": {
                    "name": "Joe"
                  },
                  "agentUserData": {
                    "name": [
                      {
                        "value": "Joe",
                        "visibility": "VISIBLE",
                        "userId": {
                          "appId": "myapp",
                          "referenceId": "user0"
                        }
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
        let expectedResponse = AppUserResponse(
            userId: EntityId(
                referenceId: "user-0",
                appId: "myapp",
                organizationId: "acme",
                agentId: "support",
                type: .userProfile
            ),
            agentUserId: "aus_1234567890",
            identifiers: [],
            data: [
                "name": UserData(
                    value: "Joe",
                    visibility: .visible
                )
            ],
            allUserData: [
                "myapp": [
                    "name": "Joe"
                ]
            ],
            defaultUserData: [
                "name": "Joe"
            ],
            agentUserData: [
                "name": [
                    UserDataWithReference(
                        value: "Joe",
                        visibility: .visible,
                        userId: EntityIdFilter(
                            appId: "myapp",
                            referenceId: "user0"
                        )
                    )
                ]
            ]
        )
        let response = try await client.users.get(
            userId: "user-0",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}