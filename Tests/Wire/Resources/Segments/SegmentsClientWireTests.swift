import Foundation
import Testing
import Api

@Suite("SegmentsClient Wire Tests") struct SegmentsClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "segments": [
                    {
                      "segmentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "referencedKnowledgeBaseCount": 1000000,
                      "referencedDocumentCount": 1000000,
                      "status": "ACTIVE",
                      "name": "name",
                      "description": "description",
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
                      "segmentId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "createdAt": "2024-01-15T09:30:00Z",
                      "updatedAt": "2024-01-15T09:30:00Z",
                      "referencedKnowledgeBaseCount": 1000000,
                      "referencedDocumentCount": 1000000,
                      "status": "ACTIVE",
                      "name": "name",
                      "description": "description",
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
        let expectedResponse = SegmentsSearchResponse(
            segments: [
                SegmentResponse(
                    segmentId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    referencedKnowledgeBaseCount: Optional(1000000),
                    referencedDocumentCount: Optional(1000000),
                    status: .active,
                    name: "name",
                    description: Optional("description"),
                    precondition: .user(
                        .init(
                            key: "key",
                            value: Optional("value"),
                            values: Optional([
                                "values",
                                "values"
                            ]),
                            operator: Optional(.not)
                        )
                    )
                ),
                SegmentResponse(
                    segmentId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    referencedKnowledgeBaseCount: Optional(1000000),
                    referencedDocumentCount: Optional(1000000),
                    status: .active,
                    name: "name",
                    description: Optional("description"),
                    precondition: .user(
                        .init(
                            key: "key",
                            value: Optional("value"),
                            values: Optional([
                                "values",
                                "values"
                            ]),
                            operator: Optional(.not)
                        )
                    )
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.segments.search(
            request: SegmentsSearchRequest(

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
                  "segmentId": {
                    "referenceId": "admin-users",
                    "appId": "auth-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "SEGMENT"
                  },
                  "name": "Admin users",
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-01-15T12:30:00Z",
                  "referencedKnowledgeBaseCount": 5,
                  "referencedDocumentCount": 34,
                  "status": "ACTIVE",
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
        let expectedResponse = SegmentResponse(
            segmentId: EntityId(
                referenceId: "admin-users",
                appId: "auth-app",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            ),
            name: "Admin users",
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601),
            referencedKnowledgeBaseCount: Optional(5),
            referencedDocumentCount: Optional(34),
            status: .active,
            precondition: .group(
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
            )
        )
        let response = try await client.segments.createOrUpdate(
            request: SegmentRequest(
                name: "Admin users",
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
                segmentId: EntityIdBase(
                    referenceId: "admin-users"
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
                  "segmentId": {
                    "referenceId": "admin-users",
                    "appId": "auth-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "SEGMENT"
                  },
                  "name": "Admin users",
                  "createdAt": "2025-01-01T00:00:00Z",
                  "updatedAt": "2025-01-15T12:30:00Z",
                  "referencedKnowledgeBaseCount": 5,
                  "referencedDocumentCount": 34,
                  "status": "ACTIVE",
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
        let expectedResponse = SegmentResponse(
            segmentId: EntityId(
                referenceId: "admin-users",
                appId: "auth-app",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            ),
            name: "Admin users",
            createdAt: try! Date("2025-01-01T00:00:00Z", strategy: .iso8601),
            updatedAt: try! Date("2025-01-15T12:30:00Z", strategy: .iso8601),
            referencedKnowledgeBaseCount: Optional(5),
            referencedDocumentCount: Optional(34),
            status: .active,
            precondition: .group(
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
            )
        )
        let response = try await client.segments.get(
            segmentReferenceId: "admin-users",
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
                  "segmentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "referencedKnowledgeBaseCount": 1000000,
                  "referencedDocumentCount": 1000000,
                  "status": "ACTIVE",
                  "name": "name",
                  "description": "description",
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
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            appId: "<username>",
            appSecret: "<password>",
            urlSession: stub.urlSession
        )
        let expectedResponse = SegmentResponse(
            segmentId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            referencedKnowledgeBaseCount: Optional(1000000),
            referencedDocumentCount: Optional(1000000),
            status: .active,
            name: "name",
            description: Optional("description"),
            precondition: .user(
                .init(
                    key: "key",
                    value: Optional("value"),
                    values: Optional([
                        "values",
                        "values"
                    ]),
                    operator: Optional(.not)
                )
            )
        )
        let response = try await client.segments.patch(
            segmentReferenceId: "segmentReferenceId",
            request: SegmentPatchRequest(

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
                  "segmentId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "createdAt": "2024-01-15T09:30:00Z",
                  "updatedAt": "2024-01-15T09:30:00Z",
                  "referencedKnowledgeBaseCount": 1000000,
                  "referencedDocumentCount": 1000000,
                  "status": "ACTIVE",
                  "name": "name",
                  "description": "description",
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
                """.utf8
            )
        )
        let client = MavenAGI(
            baseURL: "https://api.fern.com",
            appId: "<username>",
            appSecret: "<password>",
            urlSession: stub.urlSession
        )
        let expectedResponse = SegmentResponse(
            segmentId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            referencedKnowledgeBaseCount: Optional(1000000),
            referencedDocumentCount: Optional(1000000),
            status: .active,
            name: "name",
            description: Optional("description"),
            precondition: .user(
                .init(
                    key: "key",
                    value: Optional("value"),
                    values: Optional([
                        "values",
                        "values"
                    ]),
                    operator: Optional(.not)
                )
            )
        )
        let response = try await client.segments.delete(
            segmentReferenceId: "segmentReferenceId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}