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
                      "status": "ACTIVE",
                      "name": "name",
                      "precondition": {
                        "preconditionType": "user",
                        "key": "key",
                        "value": "value",
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
                      "status": "ACTIVE",
                      "name": "name",
                      "precondition": {
                        "preconditionType": "user",
                        "key": "key",
                        "value": "value",
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
                    status: .active,
                    name: "name",
                    precondition: .user(
                        .init(
                            key: "key",
                            value: Optional("value"),
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
                    status: .active,
                    name: "name",
                    precondition: .user(
                        .init(
                            key: "key",
                            value: Optional("value"),
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
                  "status": "ACTIVE",
                  "name": "name",
                  "precondition": {
                    "preconditionType": "user",
                    "key": "key",
                    "value": "value",
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
            status: .active,
            name: "name",
            precondition: .user(
                .init(
                    key: "key",
                    value: Optional("value"),
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
}