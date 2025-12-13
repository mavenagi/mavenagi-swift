import Foundation
import Testing
import Api

@Suite("OrganizationsClient Wire Tests") struct OrganizationsClientWireTests {
    @Test func create1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "organizationId": {
                    "referenceId": "x"
                  },
                  "name": "name",
                  "defaultLanguage": "defaultLanguage"
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
        let expectedResponse = Organization(
            organizationId: EntityIdBase(
                referenceId: "x"
            ),
            name: "name",
            defaultLanguage: "defaultLanguage"
        )
        let response = try await client.organizations.create(
            organizationReferenceId: "organizationReferenceId",
            request: CreateOrganizationRequest(
                name: "name",
                defaultLanguage: "defaultLanguage"
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
                  "organizationId": {
                    "referenceId": "x"
                  },
                  "name": "name",
                  "defaultLanguage": "defaultLanguage"
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
        let expectedResponse = Organization(
            organizationId: EntityIdBase(
                referenceId: "x"
            ),
            name: "name",
            defaultLanguage: "defaultLanguage"
        )
        let response = try await client.organizations.get(
            organizationReferenceId: "organizationReferenceId",
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
                  "organizationId": {
                    "referenceId": "x"
                  },
                  "name": "name",
                  "defaultLanguage": "defaultLanguage"
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
        let expectedResponse = Organization(
            organizationId: EntityIdBase(
                referenceId: "x"
            ),
            name: "name",
            defaultLanguage: "defaultLanguage"
        )
        let response = try await client.organizations.patch(
            organizationReferenceId: "organizationReferenceId",
            request: OrganizationPatchRequest(

            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getConversationTable1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "headers": [
                    "count",
                    "avg_first_response_time",
                    "percentile_first_response_time"
                  ],
                  "rows": [
                    {
                      "identifier": {
                        "Category": {
                          "type": "string",
                          "value": "Sales"
                        },
                        "CreatedAt": {
                          "type": "dateTime",
                          "value": "2023-10-01T00:00:00Z"
                        }
                      },
                      "data": {
                        "count": {
                          "type": "double",
                          "value": 5
                        },
                        "avg_first_response_time": {
                          "type": "millisecond",
                          "value": 150
                        },
                        "percentile_handle_time": {
                          "type": "millisecond",
                          "value": 110
                        }
                      }
                    },
                    {
                      "identifier": {
                        "Category": {
                          "type": "string",
                          "value": "Support"
                        },
                        "CreatedAt": {
                          "type": "dateTime",
                          "value": "2023-10-01T00:00:00Z"
                        }
                      },
                      "data": {
                        "count": {
                          "type": "double",
                          "value": 10
                        },
                        "avg_first_response_time": {
                          "type": "millisecond",
                          "value": 300
                        },
                        "percentile_handle_time": {
                          "type": "millisecond",
                          "value": 250
                        }
                      }
                    },
                    {
                      "identifier": {
                        "Category": {
                          "type": "string",
                          "value": "Sales",
                          "CreatedAt": {
                            "type": "dateTime",
                            "value": "2023-10-02T00:00:00Z"
                          }
                        }
                      },
                      "data": {
                        "count": {
                          "type": "double",
                          "value": 7
                        },
                        "avg_first_response_time": {
                          "type": "millisecond",
                          "value": 180
                        },
                        "percentile_handle_time": {
                          "type": "millisecond",
                          "value": 180
                        }
                      }
                    },
                    {
                      "identifier": {
                        "Category": {
                          "type": "string",
                          "value": "Support"
                        },
                        "CreatedAt": {
                          "type": "dateTime",
                          "value": "2023-10-02T00:00:00Z"
                        }
                      },
                      "data": {
                        "count": {
                          "type": "double",
                          "value": 8
                        },
                        "avg_first_response_time": {
                          "type": "millisecond",
                          "value": 320
                        },
                        "percentile_handle_time": {
                          "type": "millisecond",
                          "value": 220
                        }
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
        let expectedResponse = ConversationTableResponse(
            headers: [
                "count",
                "avg_first_response_time",
                "percentile_first_response_time"
            ],
            rows: [
                ConversationRow(
                    identifier: [
                        .category: "Sales", 
                        .createdAt: try! Date("2023-10-01T00:00:00Z", strategy: .iso8601)
                    ],
                    data: [
                        "count": 5, 
                        "avg_first_response_time": 150, 
                        "percentile_handle_time": 110
                    ]
                ),
                ConversationRow(
                    identifier: [
                        .category: "Support", 
                        .createdAt: try! Date("2023-10-01T00:00:00Z", strategy: .iso8601)
                    ],
                    data: [
                        "count": 10, 
                        "avg_first_response_time": 300, 
                        "percentile_handle_time": 250
                    ]
                ),
                ConversationRow(
                    identifier: [
                        .category: "Sales"
                    ],
                    data: [
                        "count": 7, 
                        "avg_first_response_time": 180, 
                        "percentile_handle_time": 180
                    ]
                ),
                ConversationRow(
                    identifier: [
                        .category: "Support", 
                        .createdAt: try! Date("2023-10-02T00:00:00Z", strategy: .iso8601)
                    ],
                    data: [
                        "count": 8, 
                        "avg_first_response_time": 320, 
                        "percentile_handle_time": 220
                    ]
                )
            ]
        )
        let response = try await client.organizations.getConversationTable(
            request: ConversationTableRequest(
                conversationFilter: ConversationFilter(
                    languages: [
                        "en",
                        "es"
                    ]
                ),
                timeGrouping: .day,
                fieldGroupings: [
                    ConversationGroupBy(
                        field: .category
                    )
                ],
                columnDefinitions: [
                    ConversationColumnDefinition(
                        header: "count",
                        metric: ConversationMetric.count(
                            .init(

                            )
                        )
                    ),
                    ConversationColumnDefinition(
                        header: "avg_first_response_time",
                        metric: ConversationMetric.average(
                            .init(
                                targetField: .firstResponseTime
                            )
                        )
                    ),
                    ConversationColumnDefinition(
                        header: "percentile_handle_time",
                        metric: ConversationMetric.percentile(
                            .init(
                                targetField: .handleTime,
                                percentile: 25
                            )
                        )
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getConversationChart1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "type": "pieChart",
                  "series": {
                    "name": "Series",
                    "data": [
                      {
                        "label": "Sales",
                        "y": 5
                      },
                      {
                        "label": "Support",
                        "y": 10
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
        let expectedResponse = .pieChart(
            .init(
                series: Series(
                    name: "Series",
                    data: [
                        LabeledPoint(
                            label: "Sales",
                            y: 5
                        ),
                        LabeledPoint(
                            label: "Support",
                            y: 10
                        )
                    ]
                )
            )
        )
        let response = try await client.organizations.getConversationChart(
            request: ConversationChartRequest.pieChart(
                .init(
                    conversationFilter: ConversationFilter(
                        languages: [
                            "en",
                            "es"
                        ]
                    ),
                    groupBy: ConversationGroupBy(
                        field: .category
                    ),
                    metric: ConversationMetric.count(
                        .init(

                        )
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getConversationChart2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "type": "dateHistogram",
                  "timeSeries": [
                    {
                      "name": "Sales",
                      "data": [
                        {
                          "x": 1633046400000,
                          "y": 5
                        },
                        {
                          "x": 1633132800000,
                          "y": 7
                        }
                      ]
                    },
                    {
                      "name": "Support",
                      "data": [
                        {
                          "x": 1633046400000,
                          "y": 10
                        },
                        {
                          "x": 1633132800000,
                          "y": 8
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
            appId: "<username>",
            appSecret: "<password>",
            urlSession: stub.urlSession
        )
        let expectedResponse = .dateHistogram(
            .init(
                timeSeries: [
                    TimeSeries(
                        name: "Sales",
                        data: [
                            TimeDataPoint(
                                x: 1633046400000,
                                y: 5
                            ),
                            TimeDataPoint(
                                x: 1633132800000,
                                y: 7
                            )
                        ]
                    ),
                    TimeSeries(
                        name: "Support",
                        data: [
                            TimeDataPoint(
                                x: 1633046400000,
                                y: 10
                            ),
                            TimeDataPoint(
                                x: 1633132800000,
                                y: 8
                            )
                        ]
                    )
                ]
            )
        )
        let response = try await client.organizations.getConversationChart(
            request: ConversationChartRequest.dateHistogram(
                .init(
                    conversationFilter: ConversationFilter(
                        languages: [
                            "en",
                            "es"
                        ]
                    ),
                    timeInterval: .day,
                    groupBy: ConversationGroupBy(
                        field: .category
                    ),
                    metric: ConversationMetric.count(
                        .init(

                        )
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getConversationChart3() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "type": "barChart",
                  "series": [
                    {
                      "name": "Resolved",
                      "data": [
                        {
                          "label": "Sales",
                          "y": 5
                        },
                        {
                          "label": "Support",
                          "y": 10
                        }
                      ]
                    },
                    {
                      "name": "Escalated",
                      "data": [
                        {
                          "label": "Sales",
                          "y": 7
                        },
                        {
                          "label": "Support",
                          "y": 8
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
            appId: "<username>",
            appSecret: "<password>",
            urlSession: stub.urlSession
        )
        let expectedResponse = .barChart(
            .init(
                series: [
                    Series(
                        name: "Resolved",
                        data: [
                            LabeledPoint(
                                label: "Sales",
                                y: 5
                            ),
                            LabeledPoint(
                                label: "Support",
                                y: 10
                            )
                        ]
                    ),
                    Series(
                        name: "Escalated",
                        data: [
                            LabeledPoint(
                                label: "Sales",
                                y: 7
                            ),
                            LabeledPoint(
                                label: "Support",
                                y: 8
                            )
                        ]
                    )
                ]
            )
        )
        let response = try await client.organizations.getConversationChart(
            request: ConversationChartRequest.barChart(
                .init(
                    conversationFilter: ConversationFilter(
                        languages: [
                            "en",
                            "es"
                        ]
                    ),
                    barDefinition: ConversationGroupBy(
                        field: .category
                    ),
                    metric: ConversationMetric.count(
                        .init(

                        )
                    ),
                    verticalGrouping: ConversationGroupBy(
                        field: .resolutionStatus
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}