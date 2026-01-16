import Foundation
import Testing
import Api

@Suite("EventsClient Wire Tests") struct EventsClientWireTests {
    @Test func create1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "eventType": "userEvent",
                  "id": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "createdAt": "2024-01-15T09:30:00Z",
                  "eventName": "BUTTON_CLICKED",
                  "userInfo": {
                    "id": {
                      "organizationId": "organizationId",
                      "agentId": "agentId",
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "userDisplayName": "userDisplayName"
                  },
                  "feedbackInfo": [
                    {
                      "rating": 1.1,
                      "thumbUp": true,
                      "survey": {
                        "surveyQuestion": "surveyQuestion",
                        "surveyAnswer": "surveyAnswer"
                      }
                    },
                    {
                      "rating": 1.1,
                      "thumbUp": true,
                      "survey": {
                        "surveyQuestion": "surveyQuestion",
                        "surveyAnswer": "surveyAnswer"
                      }
                    }
                  ],
                  "pageInfo": {
                    "pageName": "pageName",
                    "pageUrl": "pageUrl",
                    "pageTitle": "pageTitle",
                    "linkUrl": "linkUrl",
                    "elementId": "elementId"
                  },
                  "timestamp": "2024-01-15T09:30:00Z",
                  "references": [
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
                  ],
                  "sourceInfo": {
                    "type": "WEB",
                    "deviceInfo": {
                      "type": "DESKTOP",
                      "name": "name",
                      "version": "version",
                      "osInfo": {
                        "type": "WINDOWS",
                        "name": "name",
                        "version": "version"
                      }
                    },
                    "browserInfo": {
                      "type": "CHROME",
                      "name": "name",
                      "version": "version",
                      "userAgent": "userAgent"
                    },
                    "geoInfo": {
                      "city": "city",
                      "state": "state",
                      "country": "country",
                      "region": "region",
                      "latitude": 1.1,
                      "longitude": 1.1
                    },
                    "ipInfo": {
                      "ip": "ip"
                    },
                    "languageInfo": {
                      "code": "code"
                    }
                  },
                  "sessionInfo": {
                    "id": "id",
                    "start": "2024-01-15T09:30:00Z",
                    "end": "2024-01-15T09:30:00Z",
                    "duration": 1000000
                  },
                  "contextInfo": {
                    "additionalData": {
                      "additionalData": "additionalData"
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
        let expectedResponse = .userEvent(
            .init(
                id: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                eventName: .buttonClicked,
                userInfo: EventUserInfo(
                    id: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    userDisplayName: Optional("userDisplayName")
                ),
                feedbackInfo: Optional([
                    FeedbackInfo(
                        rating: Optional(1.1),
                        thumbUp: Optional(true),
                        survey: Optional(SurveyInfo(
                            surveyQuestion: Optional("surveyQuestion"),
                            surveyAnswer: Optional("surveyAnswer")
                        ))
                    ),
                    FeedbackInfo(
                        rating: Optional(1.1),
                        thumbUp: Optional(true),
                        survey: Optional(SurveyInfo(
                            surveyQuestion: Optional("surveyQuestion"),
                            surveyAnswer: Optional("surveyAnswer")
                        ))
                    )
                ]),
                pageInfo: Optional(PageInfo(
                    pageName: Optional("pageName"),
                    pageUrl: Optional("pageUrl"),
                    pageTitle: Optional("pageTitle"),
                    linkUrl: Optional("linkUrl"),
                    elementId: Optional("elementId")
                )),
                timestamp: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                references: Optional([]),
                sourceInfo: Optional(SourceInfo(
                    type: .web,
                    deviceInfo: Optional(DeviceInfo(
                        type: .desktop,
                        name: Optional("name"),
                        version: Optional("version"),
                        osInfo: Optional(OsInfo(
                            type: Optional(.windows),
                            name: Optional("name"),
                            version: Optional("version")
                        ))
                    )),
                    browserInfo: Optional(BrowserInfo(
                        type: .chrome,
                        name: Optional("name"),
                        version: Optional("version"),
                        userAgent: Optional("userAgent")
                    )),
                    geoInfo: Optional(GeoInfo(
                        city: Optional("city"),
                        state: Optional("state"),
                        country: Optional("country"),
                        region: Optional("region"),
                        latitude: Optional(1.1),
                        longitude: Optional(1.1)
                    )),
                    ipInfo: Optional(IpInfo(
                        ip: Optional("ip")
                    )),
                    languageInfo: Optional(LanguageInfo(
                        code: Optional("code")
                    ))
                )),
                sessionInfo: Optional(SessionInfo(
                    id: "id",
                    start: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    end: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    duration: Optional(1000000)
                )),
                contextInfo: Optional(ContextInfo(
                    additionalData: [
                        "additionalData": "additionalData"
                    ]
                ))
            )
        )
        let response = try await client.events.create(
            request: EventRequest.userEvent(
                .init(
                    id: EntityIdBase(
                        referenceId: "x"
                    ),
                    eventName: .buttonClicked,
                    userInfo: EventUserInfoBase(
                        id: EntityIdBase(
                            referenceId: "x"
                        )
                    )
                )
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
                  "events": [
                    {
                      "eventType": "userEvent",
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "createdAt": "2024-01-15T09:30:00Z",
                      "eventName": "BUTTON_CLICKED",
                      "userInfo": {
                        "id": {
                          "organizationId": "organizationId",
                          "agentId": "agentId",
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "userDisplayName": "userDisplayName"
                      },
                      "feedbackInfo": [
                        {
                          "rating": 1.1,
                          "thumbUp": true,
                          "survey": {
                            "surveyQuestion": "surveyQuestion",
                            "surveyAnswer": "surveyAnswer"
                          }
                        },
                        {
                          "rating": 1.1,
                          "thumbUp": true,
                          "survey": {
                            "surveyQuestion": "surveyQuestion",
                            "surveyAnswer": "surveyAnswer"
                          }
                        }
                      ],
                      "pageInfo": {
                        "pageName": "pageName",
                        "pageUrl": "pageUrl",
                        "pageTitle": "pageTitle",
                        "linkUrl": "linkUrl",
                        "elementId": "elementId"
                      },
                      "timestamp": "2024-01-15T09:30:00Z",
                      "references": [
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
                      ],
                      "sourceInfo": {
                        "type": "WEB",
                        "deviceInfo": {
                          "type": "DESKTOP",
                          "name": "name",
                          "version": "version",
                          "osInfo": {
                            "type": "WINDOWS",
                            "name": "name",
                            "version": "version"
                          }
                        },
                        "browserInfo": {
                          "type": "CHROME",
                          "name": "name",
                          "version": "version",
                          "userAgent": "userAgent"
                        },
                        "geoInfo": {
                          "city": "city",
                          "state": "state",
                          "country": "country",
                          "region": "region",
                          "latitude": 1.1,
                          "longitude": 1.1
                        },
                        "ipInfo": {
                          "ip": "ip"
                        },
                        "languageInfo": {
                          "code": "code"
                        }
                      },
                      "sessionInfo": {
                        "id": "id",
                        "start": "2024-01-15T09:30:00Z",
                        "end": "2024-01-15T09:30:00Z",
                        "duration": 1000000
                      },
                      "contextInfo": {
                        "additionalData": {
                          "additionalData": "additionalData"
                        }
                      }
                    },
                    {
                      "eventType": "userEvent",
                      "id": {
                        "organizationId": "organizationId",
                        "agentId": "agentId",
                        "type": "AGENT",
                        "appId": "appId",
                        "referenceId": "x"
                      },
                      "createdAt": "2024-01-15T09:30:00Z",
                      "eventName": "BUTTON_CLICKED",
                      "userInfo": {
                        "id": {
                          "organizationId": "organizationId",
                          "agentId": "agentId",
                          "type": "AGENT",
                          "appId": "appId",
                          "referenceId": "x"
                        },
                        "userDisplayName": "userDisplayName"
                      },
                      "feedbackInfo": [
                        {
                          "rating": 1.1,
                          "thumbUp": true,
                          "survey": {
                            "surveyQuestion": "surveyQuestion",
                            "surveyAnswer": "surveyAnswer"
                          }
                        },
                        {
                          "rating": 1.1,
                          "thumbUp": true,
                          "survey": {
                            "surveyQuestion": "surveyQuestion",
                            "surveyAnswer": "surveyAnswer"
                          }
                        }
                      ],
                      "pageInfo": {
                        "pageName": "pageName",
                        "pageUrl": "pageUrl",
                        "pageTitle": "pageTitle",
                        "linkUrl": "linkUrl",
                        "elementId": "elementId"
                      },
                      "timestamp": "2024-01-15T09:30:00Z",
                      "references": [
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
                      ],
                      "sourceInfo": {
                        "type": "WEB",
                        "deviceInfo": {
                          "type": "DESKTOP",
                          "name": "name",
                          "version": "version",
                          "osInfo": {
                            "type": "WINDOWS",
                            "name": "name",
                            "version": "version"
                          }
                        },
                        "browserInfo": {
                          "type": "CHROME",
                          "name": "name",
                          "version": "version",
                          "userAgent": "userAgent"
                        },
                        "geoInfo": {
                          "city": "city",
                          "state": "state",
                          "country": "country",
                          "region": "region",
                          "latitude": 1.1,
                          "longitude": 1.1
                        },
                        "ipInfo": {
                          "ip": "ip"
                        },
                        "languageInfo": {
                          "code": "code"
                        }
                      },
                      "sessionInfo": {
                        "id": "id",
                        "start": "2024-01-15T09:30:00Z",
                        "end": "2024-01-15T09:30:00Z",
                        "duration": 1000000
                      },
                      "contextInfo": {
                        "additionalData": {
                          "additionalData": "additionalData"
                        }
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
        let expectedResponse = EventsSearchResponse(
            events: [
                .userEvent(
                    .init(
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        eventName: .buttonClicked,
                        userInfo: EventUserInfo(
                            id: Optional(EntityId(
                                organizationId: "organizationId",
                                agentId: "agentId",
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            )),
                            userDisplayName: Optional("userDisplayName")
                        ),
                        feedbackInfo: Optional([
                            FeedbackInfo(
                                rating: Optional(1.1),
                                thumbUp: Optional(true),
                                survey: Optional(SurveyInfo(
                                    surveyQuestion: Optional("surveyQuestion"),
                                    surveyAnswer: Optional("surveyAnswer")
                                ))
                            ),
                            FeedbackInfo(
                                rating: Optional(1.1),
                                thumbUp: Optional(true),
                                survey: Optional(SurveyInfo(
                                    surveyQuestion: Optional("surveyQuestion"),
                                    surveyAnswer: Optional("surveyAnswer")
                                ))
                            )
                        ]),
                        pageInfo: Optional(PageInfo(
                            pageName: Optional("pageName"),
                            pageUrl: Optional("pageUrl"),
                            pageTitle: Optional("pageTitle"),
                            linkUrl: Optional("linkUrl"),
                            elementId: Optional("elementId")
                        )),
                        timestamp: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        references: Optional([]),
                        sourceInfo: Optional(SourceInfo(
                            type: .web,
                            deviceInfo: Optional(DeviceInfo(
                                type: .desktop,
                                name: Optional("name"),
                                version: Optional("version"),
                                osInfo: Optional(OsInfo(
                                    type: Optional(.windows),
                                    name: Optional("name"),
                                    version: Optional("version")
                                ))
                            )),
                            browserInfo: Optional(BrowserInfo(
                                type: .chrome,
                                name: Optional("name"),
                                version: Optional("version"),
                                userAgent: Optional("userAgent")
                            )),
                            geoInfo: Optional(GeoInfo(
                                city: Optional("city"),
                                state: Optional("state"),
                                country: Optional("country"),
                                region: Optional("region"),
                                latitude: Optional(1.1),
                                longitude: Optional(1.1)
                            )),
                            ipInfo: Optional(IpInfo(
                                ip: Optional("ip")
                            )),
                            languageInfo: Optional(LanguageInfo(
                                code: Optional("code")
                            ))
                        )),
                        sessionInfo: Optional(SessionInfo(
                            id: "id",
                            start: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                            end: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                            duration: Optional(1000000)
                        )),
                        contextInfo: Optional(ContextInfo(
                            additionalData: [
                                "additionalData": "additionalData"
                            ]
                        ))
                    )
                ),
                .userEvent(
                    .init(
                        id: EntityId(
                            organizationId: "organizationId",
                            agentId: "agentId",
                            type: .agent,
                            appId: "appId",
                            referenceId: "x"
                        ),
                        createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        eventName: .buttonClicked,
                        userInfo: EventUserInfo(
                            id: Optional(EntityId(
                                organizationId: "organizationId",
                                agentId: "agentId",
                                type: .agent,
                                appId: "appId",
                                referenceId: "x"
                            )),
                            userDisplayName: Optional("userDisplayName")
                        ),
                        feedbackInfo: Optional([
                            FeedbackInfo(
                                rating: Optional(1.1),
                                thumbUp: Optional(true),
                                survey: Optional(SurveyInfo(
                                    surveyQuestion: Optional("surveyQuestion"),
                                    surveyAnswer: Optional("surveyAnswer")
                                ))
                            ),
                            FeedbackInfo(
                                rating: Optional(1.1),
                                thumbUp: Optional(true),
                                survey: Optional(SurveyInfo(
                                    surveyQuestion: Optional("surveyQuestion"),
                                    surveyAnswer: Optional("surveyAnswer")
                                ))
                            )
                        ]),
                        pageInfo: Optional(PageInfo(
                            pageName: Optional("pageName"),
                            pageUrl: Optional("pageUrl"),
                            pageTitle: Optional("pageTitle"),
                            linkUrl: Optional("linkUrl"),
                            elementId: Optional("elementId")
                        )),
                        timestamp: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                        references: Optional([]),
                        sourceInfo: Optional(SourceInfo(
                            type: .web,
                            deviceInfo: Optional(DeviceInfo(
                                type: .desktop,
                                name: Optional("name"),
                                version: Optional("version"),
                                osInfo: Optional(OsInfo(
                                    type: Optional(.windows),
                                    name: Optional("name"),
                                    version: Optional("version")
                                ))
                            )),
                            browserInfo: Optional(BrowserInfo(
                                type: .chrome,
                                name: Optional("name"),
                                version: Optional("version"),
                                userAgent: Optional("userAgent")
                            )),
                            geoInfo: Optional(GeoInfo(
                                city: Optional("city"),
                                state: Optional("state"),
                                country: Optional("country"),
                                region: Optional("region"),
                                latitude: Optional(1.1),
                                longitude: Optional(1.1)
                            )),
                            ipInfo: Optional(IpInfo(
                                ip: Optional("ip")
                            )),
                            languageInfo: Optional(LanguageInfo(
                                code: Optional("code")
                            ))
                        )),
                        sessionInfo: Optional(SessionInfo(
                            id: "id",
                            start: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                            end: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                            duration: Optional(1000000)
                        )),
                        contextInfo: Optional(ContextInfo(
                            additionalData: [
                                "additionalData": "additionalData"
                            ]
                        ))
                    )
                )
            ],
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.events.search(
            request: EventsSearchRequest(

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
                  "eventType": "userEvent",
                  "id": {
                    "organizationId": "organizationId",
                    "agentId": "agentId",
                    "type": "AGENT",
                    "appId": "appId",
                    "referenceId": "x"
                  },
                  "createdAt": "2024-01-15T09:30:00Z",
                  "eventName": "BUTTON_CLICKED",
                  "userInfo": {
                    "id": {
                      "organizationId": "organizationId",
                      "agentId": "agentId",
                      "type": "AGENT",
                      "appId": "appId",
                      "referenceId": "x"
                    },
                    "userDisplayName": "userDisplayName"
                  },
                  "feedbackInfo": [
                    {
                      "rating": 1.1,
                      "thumbUp": true,
                      "survey": {
                        "surveyQuestion": "surveyQuestion",
                        "surveyAnswer": "surveyAnswer"
                      }
                    },
                    {
                      "rating": 1.1,
                      "thumbUp": true,
                      "survey": {
                        "surveyQuestion": "surveyQuestion",
                        "surveyAnswer": "surveyAnswer"
                      }
                    }
                  ],
                  "pageInfo": {
                    "pageName": "pageName",
                    "pageUrl": "pageUrl",
                    "pageTitle": "pageTitle",
                    "linkUrl": "linkUrl",
                    "elementId": "elementId"
                  },
                  "timestamp": "2024-01-15T09:30:00Z",
                  "references": [
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
                  ],
                  "sourceInfo": {
                    "type": "WEB",
                    "deviceInfo": {
                      "type": "DESKTOP",
                      "name": "name",
                      "version": "version",
                      "osInfo": {
                        "type": "WINDOWS",
                        "name": "name",
                        "version": "version"
                      }
                    },
                    "browserInfo": {
                      "type": "CHROME",
                      "name": "name",
                      "version": "version",
                      "userAgent": "userAgent"
                    },
                    "geoInfo": {
                      "city": "city",
                      "state": "state",
                      "country": "country",
                      "region": "region",
                      "latitude": 1.1,
                      "longitude": 1.1
                    },
                    "ipInfo": {
                      "ip": "ip"
                    },
                    "languageInfo": {
                      "code": "code"
                    }
                  },
                  "sessionInfo": {
                    "id": "id",
                    "start": "2024-01-15T09:30:00Z",
                    "end": "2024-01-15T09:30:00Z",
                    "duration": 1000000
                  },
                  "contextInfo": {
                    "additionalData": {
                      "additionalData": "additionalData"
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
        let expectedResponse = .userEvent(
            .init(
                id: EntityId(
                    organizationId: "organizationId",
                    agentId: "agentId",
                    type: .agent,
                    appId: "appId",
                    referenceId: "x"
                ),
                createdAt: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                eventName: .buttonClicked,
                userInfo: EventUserInfo(
                    id: Optional(EntityId(
                        organizationId: "organizationId",
                        agentId: "agentId",
                        type: .agent,
                        appId: "appId",
                        referenceId: "x"
                    )),
                    userDisplayName: Optional("userDisplayName")
                ),
                feedbackInfo: Optional([
                    FeedbackInfo(
                        rating: Optional(1.1),
                        thumbUp: Optional(true),
                        survey: Optional(SurveyInfo(
                            surveyQuestion: Optional("surveyQuestion"),
                            surveyAnswer: Optional("surveyAnswer")
                        ))
                    ),
                    FeedbackInfo(
                        rating: Optional(1.1),
                        thumbUp: Optional(true),
                        survey: Optional(SurveyInfo(
                            surveyQuestion: Optional("surveyQuestion"),
                            surveyAnswer: Optional("surveyAnswer")
                        ))
                    )
                ]),
                pageInfo: Optional(PageInfo(
                    pageName: Optional("pageName"),
                    pageUrl: Optional("pageUrl"),
                    pageTitle: Optional("pageTitle"),
                    linkUrl: Optional("linkUrl"),
                    elementId: Optional("elementId")
                )),
                timestamp: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                references: Optional([]),
                sourceInfo: Optional(SourceInfo(
                    type: .web,
                    deviceInfo: Optional(DeviceInfo(
                        type: .desktop,
                        name: Optional("name"),
                        version: Optional("version"),
                        osInfo: Optional(OsInfo(
                            type: Optional(.windows),
                            name: Optional("name"),
                            version: Optional("version")
                        ))
                    )),
                    browserInfo: Optional(BrowserInfo(
                        type: .chrome,
                        name: Optional("name"),
                        version: Optional("version"),
                        userAgent: Optional("userAgent")
                    )),
                    geoInfo: Optional(GeoInfo(
                        city: Optional("city"),
                        state: Optional("state"),
                        country: Optional("country"),
                        region: Optional("region"),
                        latitude: Optional(1.1),
                        longitude: Optional(1.1)
                    )),
                    ipInfo: Optional(IpInfo(
                        ip: Optional("ip")
                    )),
                    languageInfo: Optional(LanguageInfo(
                        code: Optional("code")
                    ))
                )),
                sessionInfo: Optional(SessionInfo(
                    id: "id",
                    start: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    end: Optional(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)),
                    duration: Optional(1000000)
                )),
                contextInfo: Optional(ContextInfo(
                    additionalData: [
                        "additionalData": "additionalData"
                    ]
                ))
            )
        )
        let response = try await client.events.get(
            eventId: "eventId",
            appId: "appId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}