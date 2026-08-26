import Foundation
import Testing
import Api

@Suite("IntelligentFieldsClient Wire Tests") struct IntelligentFieldsClientWireTests {
    @Test func createOrUpdate1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "fieldId": {
                    "referenceId": "ticket-priority",
                    "appId": "zendesk",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "INTELLIGENT_FIELD"
                  },
                  "name": "Ticket Priority",
                  "description": "The priority of the conversation based on urgency",
                  "status": "INACTIVE",
                  "entityType": "CONVERSATION",
                  "validationType": "STRING",
                  "enumOptions": [
                    {
                      "value": "HIGH",
                      "label": "High Priority"
                    },
                    {
                      "value": "MEDIUM",
                      "label": "Medium Priority"
                    },
                    {
                      "value": "LOW",
                      "label": "Low Priority"
                    }
                  ],
                  "definition": "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
                  "createdAt": "2024-01-15T10:30:00Z",
                  "updatedAt": "2024-01-15T10:30:00Z"
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
        let expectedResponse = IntelligentFieldResponse(
            fieldId: EntityId(
                referenceId: "ticket-priority",
                appId: "zendesk",
                organizationId: "acme",
                agentId: "support",
                type: .intelligentField
            ),
            name: "Ticket Priority",
            description: Optional("The priority of the conversation based on urgency"),
            status: .inactive,
            entityType: .conversation,
            validationType: .string,
            enumOptions: Optional([
                EnumOption(
                    value: "HIGH",
                    label: Optional("High Priority")
                ),
                EnumOption(
                    value: "MEDIUM",
                    label: Optional("Medium Priority")
                ),
                EnumOption(
                    value: "LOW",
                    label: Optional("Low Priority")
                )
            ]),
            definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
            createdAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601))
        )
        let response = try await client.intelligentFields.createOrUpdate(
            request: IntelligentFieldRequest(
                entityType: .conversation,
                name: "Ticket Priority",
                description: "The priority of the conversation based on urgency",
                validationType: .string,
                definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
                enumOptions: [
                    EnumOption(
                        value: "HIGH",
                        label: "High Priority"
                    ),
                    EnumOption(
                        value: "MEDIUM",
                        label: "Medium Priority"
                    ),
                    EnumOption(
                        value: "LOW",
                        label: "Low Priority"
                    )
                ],
                fieldId: EntityIdBase(
                    referenceId: "ticket-priority"
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
                  "fieldId": {
                    "referenceId": "ticket-priority",
                    "appId": "zendesk",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "INTELLIGENT_FIELD"
                  },
                  "name": "Ticket Priority",
                  "description": "The priority of the conversation based on urgency",
                  "status": "INACTIVE",
                  "entityType": "CONVERSATION",
                  "validationType": "STRING",
                  "enumOptions": [
                    {
                      "value": "HIGH",
                      "label": "High Priority"
                    },
                    {
                      "value": "MEDIUM",
                      "label": "Medium Priority"
                    },
                    {
                      "value": "LOW",
                      "label": "Low Priority"
                    }
                  ],
                  "definition": "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
                  "createdAt": "2024-01-15T10:30:00Z",
                  "updatedAt": "2024-01-15T10:30:00Z",
                  "referencingCharters": []
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
        let expectedResponse = IntelligentFieldDetailResponse(
            fieldId: EntityId(
                referenceId: "ticket-priority",
                appId: "zendesk",
                organizationId: "acme",
                agentId: "support",
                type: .intelligentField
            ),
            name: "Ticket Priority",
            description: Optional("The priority of the conversation based on urgency"),
            status: .inactive,
            entityType: .conversation,
            validationType: .string,
            enumOptions: Optional([
                EnumOption(
                    value: "HIGH",
                    label: Optional("High Priority")
                ),
                EnumOption(
                    value: "MEDIUM",
                    label: Optional("Medium Priority")
                ),
                EnumOption(
                    value: "LOW",
                    label: Optional("Low Priority")
                )
            ]),
            definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
            createdAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601)),
            referencingCharters: Optional([])
        )
        let response = try await client.intelligentFields.get(
            fieldReferenceId: "ticket-priority",
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
                  "fieldId": {
                    "referenceId": "ticket-priority",
                    "appId": "zendesk",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "INTELLIGENT_FIELD"
                  },
                  "name": "Ticket Priority",
                  "description": "The priority of the conversation based on urgency",
                  "status": "INACTIVE",
                  "entityType": "CONVERSATION",
                  "validationType": "STRING",
                  "enumOptions": [
                    {
                      "value": "HIGH",
                      "label": "High Priority"
                    },
                    {
                      "value": "MEDIUM",
                      "label": "Medium Priority"
                    },
                    {
                      "value": "LOW",
                      "label": "Low Priority"
                    }
                  ],
                  "definition": "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
                  "createdAt": "2024-01-15T10:30:00Z",
                  "updatedAt": "2024-01-15T10:30:00Z"
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
        let expectedResponse = IntelligentFieldResponse(
            fieldId: EntityId(
                referenceId: "ticket-priority",
                appId: "zendesk",
                organizationId: "acme",
                agentId: "support",
                type: .intelligentField
            ),
            name: "Ticket Priority",
            description: Optional("The priority of the conversation based on urgency"),
            status: .inactive,
            entityType: .conversation,
            validationType: .string,
            enumOptions: Optional([
                EnumOption(
                    value: "HIGH",
                    label: Optional("High Priority")
                ),
                EnumOption(
                    value: "MEDIUM",
                    label: Optional("Medium Priority")
                ),
                EnumOption(
                    value: "LOW",
                    label: Optional("Low Priority")
                )
            ]),
            definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
            createdAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601))
        )
        let response = try await client.intelligentFields.patch(
            fieldReferenceId: "ticket-priority",
            request: .init(definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW."),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func patch2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "fieldId": {
                    "referenceId": "ticket-priority",
                    "appId": "zendesk",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "INTELLIGENT_FIELD"
                  },
                  "name": "Ticket Priority",
                  "description": "The priority of the conversation based on urgency",
                  "status": "INACTIVE",
                  "entityType": "CONVERSATION",
                  "validationType": "STRING",
                  "enumOptions": [
                    {
                      "value": "HIGH",
                      "label": "High Priority"
                    },
                    {
                      "value": "MEDIUM",
                      "label": "Medium Priority"
                    },
                    {
                      "value": "LOW",
                      "label": "Low Priority"
                    }
                  ],
                  "definition": "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
                  "createdAt": "2024-01-15T10:30:00Z",
                  "updatedAt": "2024-01-15T10:30:00Z"
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
        let expectedResponse = IntelligentFieldResponse(
            fieldId: EntityId(
                referenceId: "ticket-priority",
                appId: "zendesk",
                organizationId: "acme",
                agentId: "support",
                type: .intelligentField
            ),
            name: "Ticket Priority",
            description: Optional("The priority of the conversation based on urgency"),
            status: .inactive,
            entityType: .conversation,
            validationType: .string,
            enumOptions: Optional([
                EnumOption(
                    value: "HIGH",
                    label: Optional("High Priority")
                ),
                EnumOption(
                    value: "MEDIUM",
                    label: Optional("Medium Priority")
                ),
                EnumOption(
                    value: "LOW",
                    label: Optional("Low Priority")
                )
            ]),
            definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
            createdAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601))
        )
        let response = try await client.intelligentFields.patch(
            fieldReferenceId: "ticket-priority",
            request: .init(status: .inactive),
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
                  "fieldId": {
                    "referenceId": "ticket-priority",
                    "appId": "zendesk",
                    "organizationId": "acme",
                    "agentId": "support",
                    "type": "INTELLIGENT_FIELD"
                  },
                  "name": "Ticket Priority",
                  "description": "The priority of the conversation based on urgency",
                  "status": "INACTIVE",
                  "entityType": "CONVERSATION",
                  "validationType": "STRING",
                  "enumOptions": [
                    {
                      "value": "HIGH",
                      "label": "High Priority"
                    },
                    {
                      "value": "MEDIUM",
                      "label": "Medium Priority"
                    },
                    {
                      "value": "LOW",
                      "label": "Low Priority"
                    }
                  ],
                  "definition": "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
                  "createdAt": "2024-01-15T10:30:00Z",
                  "updatedAt": "2024-01-15T10:30:00Z"
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
        let expectedResponse = IntelligentFieldResponse(
            fieldId: EntityId(
                referenceId: "ticket-priority",
                appId: "zendesk",
                organizationId: "acme",
                agentId: "support",
                type: .intelligentField
            ),
            name: "Ticket Priority",
            description: Optional("The priority of the conversation based on urgency"),
            status: .inactive,
            entityType: .conversation,
            validationType: .string,
            enumOptions: Optional([
                EnumOption(
                    value: "HIGH",
                    label: Optional("High Priority")
                ),
                EnumOption(
                    value: "MEDIUM",
                    label: Optional("Medium Priority")
                ),
                EnumOption(
                    value: "LOW",
                    label: Optional("Low Priority")
                )
            ]),
            definition: "The priority of the conversation based on the urgency and importance; draw from the content / messages in the conversation; must be one of HIGH, MEDIUM, or LOW.",
            createdAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601)),
            updatedAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601))
        )
        let response = try await client.intelligentFields.delete(
            fieldReferenceId: "ticket-priority",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func searchValues1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "values": [
                    {
                      "fieldId": {
                        "referenceId": "ticket-priority",
                        "appId": "zendesk",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "INTELLIGENT_FIELD"
                      },
                      "name": "Ticket Priority",
                      "entityId": {
                        "referenceId": "ticket-123",
                        "appId": "zendesk",
                        "organizationId": "acme",
                        "agentId": "support",
                        "type": "CONVERSATION"
                      },
                      "value": "HIGH",
                      "confidence": 0.95,
                      "rationale": "The conversation mentions a production outage affecting multiple customers, indicating high urgency and impact.",
                      "createdAt": "2024-01-15T10:30:00Z"
                    }
                  ],
                  "totalElements": 1,
                  "totalPages": 1,
                  "size": 20,
                  "number": 0
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
        let expectedResponse = IntelligentFieldValueSearchResponse(
            values: [
                IntelligentFieldValueResponse(
                    fieldId: EntityId(
                        referenceId: "ticket-priority",
                        appId: "zendesk",
                        organizationId: "acme",
                        agentId: "support",
                        type: .intelligentField
                    ),
                    name: "Ticket Priority",
                    entityId: EntityId(
                        referenceId: "ticket-123",
                        appId: "zendesk",
                        organizationId: "acme",
                        agentId: "support",
                        type: .conversation
                    ),
                    value: Optional(JSONValue.string("HIGH")),
                    confidence: Optional(0.95),
                    rationale: Optional("The conversation mentions a production outage affecting multiple customers, indicating high urgency and impact."),
                    createdAt: Optional(try! Date("2024-01-15T10:30:00Z", strategy: .iso8601))
                )
            ],
            totalElements: 1,
            totalPages: 1,
            size: 20,
            number: 0
        )
        let response = try await client.intelligentFields.searchValues(
            request: IntelligentFieldValueSearchRequest(
                page: 0,
                size: 20,
                sortDesc: true,
                fieldFilter: IntelligentFieldValueFieldFilter(
                    fieldIds: [
                        EntityId(
                            type: .intelligentField,
                            appId: "zendesk",
                            referenceId: "ticket-priority",
                            organizationId: "acme",
                            agentId: "support"
                        )
                    ]
                ),
                entityFilter: IntelligentFieldValueEntityFilter(
                    entityIds: [
                        EntityId(
                            type: .conversation,
                            appId: "zendesk",
                            referenceId: "conv-123",
                            organizationId: "acme",
                            agentId: "support"
                        )
                    ]
                ),
                sort: .createdAt
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}