import Foundation
import Testing
import Api

@Suite("CustomersClient Wire Tests") struct CustomersClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "customers": [
                    {
                      "customerId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "assignees": [
                        "assignees"
                      ],
                      "members": [
                        "members"
                      ],
                      "name": "name",
                      "description": "description",
                      "metadata": {
                        "metadata": "metadata"
                      },
                      "status": "ACTIVE"
                    },
                    {
                      "customerId": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "assignees": [
                        "assignees"
                      ],
                      "members": [
                        "members"
                      ],
                      "name": "name",
                      "description": "description",
                      "metadata": {
                        "metadata": "metadata"
                      },
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
            appId: "<username>",
            appSecret: "<password>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CustomersSearchResponse(
            customers: [
                CustomerResponse(
                    customerId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    assignees: [],
                    members: [],
                    name: "name",
                    description: Optional("description"),
                    metadata: [
                        "metadata": "metadata"
                    ],
                    status: .active
                ),
                CustomerResponse(
                    customerId: EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    ),
                    assignees: [],
                    members: [],
                    name: "name",
                    description: Optional("description"),
                    metadata: [
                        "metadata": "metadata"
                    ],
                    status: .active
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.customers.search(
            request: CustomersSearchRequest(

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
                  "customerId": {
                    "referenceId": "acme",
                    "appId": "customer-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CUSTOMER"
                  },
                  "name": "Acme Corporation",
                  "status": "ACTIVE",
                  "description": "Acme is a company that makes widgets",
                  "metadata": {
                    "industry": "widget manufacturing",
                    "initial-note": "Acme is a great company"
                  },
                  "assignees": [],
                  "members": []
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
        let expectedResponse = CustomerResponse(
            customerId: EntityId(
                referenceId: "acme",
                appId: "customer-app",
                organizationId: "acme",
                agentId: "support",
                type: .customer
            ),
            name: "Acme Corporation",
            status: .active,
            description: Optional("Acme is a company that makes widgets"),
            metadata: [
                "industry": "widget manufacturing", 
                "initial-note": "Acme is a great company"
            ],
            assignees: [],
            members: []
        )
        let response = try await client.customers.createOrUpdate(
            request: CustomerRequest(
                customerId: EntityIdBase(
                    referenceId: "acme"
                ),
                name: "Acme Corporation"
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
                  "customerId": {
                    "referenceId": "acme",
                    "appId": "customer-app",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "CUSTOMER"
                  },
                  "name": "Acme Corporation",
                  "status": "ACTIVE",
                  "description": "Acme is a company that makes widgets",
                  "metadata": {
                    "industry": "widget manufacturing",
                    "initial-note": "Acme is a great company"
                  },
                  "assignees": [],
                  "members": []
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
        let expectedResponse = CustomerResponse(
            customerId: EntityId(
                referenceId: "acme",
                appId: "customer-app",
                organizationId: "acme",
                agentId: "support",
                type: .customer
            ),
            name: "Acme Corporation",
            status: .active,
            description: Optional("Acme is a company that makes widgets"),
            metadata: [
                "industry": "widget manufacturing", 
                "initial-note": "Acme is a great company"
            ],
            assignees: [],
            members: []
        )
        let response = try await client.customers.get(
            customerReferenceId: "acme",
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
                  "customerId": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "assignees": [
                    "assignees"
                  ],
                  "members": [
                    "members"
                  ],
                  "name": "name",
                  "description": "description",
                  "metadata": {
                    "metadata": "metadata"
                  },
                  "status": "ACTIVE"
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
        let expectedResponse = CustomerResponse(
            customerId: EntityId(
                organizationId: "organizationId",
                agentId: "agentId",
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            assignees: [],
            members: [],
            name: "name",
            description: Optional("description"),
            metadata: [
                "metadata": "metadata"
            ],
            status: .active
        )
        let response = try await client.customers.patch(
            customerReferenceId: "customerReferenceId",
            request: CustomerPatchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}