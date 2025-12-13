import Foundation
import Testing
import Api

@Suite("AnalyticsClient Wire Tests") struct AnalyticsClientWireTests {
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
        let response = try await client.analytics.getConversationTable(
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
        let response = try await client.analytics.getConversationChart(
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
        let response = try await client.analytics.getConversationChart(
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
        let response = try await client.analytics.getConversationChart(
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

    @Test func getFeedbackTable1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "headers": [
                    "feedback_count",
                    "unique_users"
                  ],
                  "rows": [
                    {
                      "identifier": {
                        "CreatedBy": {
                          "type": "string",
                          "value": "John Doe"
                        }
                      },
                      "data": {
                        "feedback_count": {
                          "type": "double",
                          "value": 5
                        }
                      }
                    },
                    {
                      "identifier": {
                        "CreatedBy": {
                          "type": "string",
                          "value": "Jane Smith"
                        }
                      },
                      "data": {
                        "feedback_count": {
                          "type": "double",
                          "value": 3
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
        let expectedResponse = FeedbackTableResponse(
            headers: [
                "feedback_count",
                "unique_users"
            ],
            rows: [
                FeedbackRow(
                    identifier: [
                        .createdBy: "John Doe"
                    ],
                    data: [
                        "feedback_count": 5
                    ]
                ),
                FeedbackRow(
                    identifier: [
                        .createdBy: "Jane Smith"
                    ],
                    data: [
                        "feedback_count": 3
                    ]
                )
            ]
        )
        let response = try await client.analytics.getFeedbackTable(
            request: FeedbackTableRequest(
                feedbackFilter: FeedbackFilter(
                    types: [
                        .thumbsUp,
                        .insert
                    ]
                ),
                fieldGroupings: [
                    FeedbackGroupBy(
                        field: .createdBy
                    )
                ],
                columnDefinitions: [
                    FeedbackColumnDefinition(
                        header: "feedback_count",
                        metric: FeedbackMetric.count(
                            .init(

                            )
                        )
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getAgentUserTable1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "headers": [
                    "user_count"
                  ],
                  "rows": [
                    {
                      "identifier": {
                        "CreatedAt": {
                          "type": "dateTime",
                          "value": "2023-10-01T00:00:00Z"
                        }
                      },
                      "data": {
                        "user_count": {
                          "type": "double",
                          "value": 5
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
        let expectedResponse = AgentUserTableResponse(
            headers: [
                "user_count"
            ],
            rows: [
                AgentUserRow(
                    identifier: [
                        .createdAt: try! Date("2023-10-01T00:00:00Z", strategy: .iso8601)
                    ],
                    data: [
                        "user_count": 5
                    ]
                )
            ]
        )
        let response = try await client.analytics.getAgentUserTable(
            request: AgentUserTableRequest(
                agentUserFilter: AgentUserFilter(
                    search: "john"
                ),
                columnDefinitions: [
                    AgentUserColumnDefinition(
                        header: "user_count",
                        metric: AgentUserMetric.count(
                            .init(

                            )
                        )
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getEventTable1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "headers": [
                    "event_count"
                  ],
                  "rows": [
                    {
                      "identifier": {
                        "EVENT_NAME": {
                          "type": "string",
                          "value": "CHAT_OPENED"
                        }
                      },
                      "data": {
                        "event_count": {
                          "type": "double",
                          "value": 50
                        }
                      }
                    },
                    {
                      "identifier": {
                        "EVENT_NAME": {
                          "type": "string",
                          "value": "CHAT_CLOSED"
                        }
                      },
                      "data": {
                        "event_count": {
                          "type": "double",
                          "value": 45
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
        let expectedResponse = EventTableResponse(
            headers: [
                "event_count"
            ],
            rows: [
                EventRow(
                    identifier: [
                        .eventName: "CHAT_OPENED"
                    ],
                    data: [
                        "event_count": 50
                    ]
                ),
                EventRow(
                    identifier: [
                        .eventName: "CHAT_CLOSED"
                    ],
                    data: [
                        "event_count": 45
                    ]
                )
            ]
        )
        let response = try await client.analytics.getEventTable(
            request: EventTableRequest(
                eventFilter: EventFilter(
                    eventTypes: [
                        .user
                    ]
                ),
                fieldGroupings: [
                    EventGroupBy(
                        field: .eventName
                    )
                ],
                columnDefinitions: [
                    EventColumnDefinition(
                        header: "event_count",
                        metric: EventMetric.count(
                            .init(

                            )
                        )
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getEventChart1() async throws -> Void {
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
        let response = try await client.analytics.getEventChart(
            request: EventChartRequest.pieChart(
                .init(
                    eventFilter: EventFilter(
                        eventTypes: [
                            .user
                        ]
                    ),
                    groupBy: EventGroupBy(
                        field: .eventName
                    ),
                    metric: EventMetric.count(
                        .init(

                        )
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getEventChart2() async throws -> Void {
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
        let response = try await client.analytics.getEventChart(
            request: EventChartRequest.dateHistogram(
                .init(
                    eventFilter: EventFilter(
                        eventTypes: [
                            .user
                        ]
                    ),
                    timeInterval: .day,
                    groupBy: EventGroupBy(
                        field: .eventName
                    ),
                    metric: EventMetric.count(
                        .init(

                        )
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getEventChart3() async throws -> Void {
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
        let response = try await client.analytics.getEventChart(
            request: EventChartRequest.barChart(
                .init(
                    eventFilter: EventFilter(
                        eventTypes: [
                            .user
                        ]
                    ),
                    barDefinition: EventGroupBy(
                        field: .eventName
                    ),
                    metric: EventMetric.count(
                        .init(

                        )
                    ),
                    verticalGrouping: EventGroupBy(
                        field: .eventType
                    )
                )
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}