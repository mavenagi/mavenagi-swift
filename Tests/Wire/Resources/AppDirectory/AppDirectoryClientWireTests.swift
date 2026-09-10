import Foundation
import Testing
import Api

@Suite("AppDirectoryClient Wire Tests") struct AppDirectoryClientWireTests {
    @Test func search1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "apps": [
                    {
                      "installed": "INSTALLED",
                      "id": "id",
                      "name": "name",
                      "developerOrganizationId": "developerOrganizationId",
                      "creator": {
                        "organizationId": "organizationId",
                        "name": "name",
                        "website": "website",
                        "email": "email",
                        "phone": "phone"
                      },
                      "visibility": "IN_DEVELOPMENT",
                      "description": "description",
                      "shortDescription": "shortDescription",
                      "logoUrl": "logoUrl",
                      "categories": [
                        "COMMUNICATION",
                        "COMMUNICATION"
                      ],
                      "capabilities": [
                        "ACTIONS",
                        "ACTIONS"
                      ],
                      "isAgentApp": true
                    },
                    {
                      "installed": "INSTALLED",
                      "id": "id",
                      "name": "name",
                      "developerOrganizationId": "developerOrganizationId",
                      "creator": {
                        "organizationId": "organizationId",
                        "name": "name",
                        "website": "website",
                        "email": "email",
                        "phone": "phone"
                      },
                      "visibility": "IN_DEVELOPMENT",
                      "description": "description",
                      "shortDescription": "shortDescription",
                      "logoUrl": "logoUrl",
                      "categories": [
                        "COMMUNICATION",
                        "COMMUNICATION"
                      ],
                      "capabilities": [
                        "ACTIONS",
                        "ACTIONS"
                      ],
                      "isAgentApp": true
                    }
                  ],
                  "allAppsCountByFilter": {
                    "countByVisibility": {
                      "IN_DEVELOPMENT": 1
                    },
                    "countByCategory": {
                      "COMMUNICATION": 1
                    }
                  },
                  "installedAppsCountByFilter": {
                    "countByVisibility": {
                      "IN_DEVELOPMENT": 1
                    },
                    "countByCategory": {
                      "COMMUNICATION": 1
                    }
                  },
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
        let expectedResponse = AppsResponse(
            apps: [
                MarketplaceApp(
                    installed: .installed,
                    id: "id",
                    name: "name",
                    developerOrganizationId: "developerOrganizationId",
                    creator: Optional(DeveloperOrganization(
                        organizationId: "organizationId",
                        name: "name",
                        website: Optional("website"),
                        email: Optional("email"),
                        phone: Optional("phone")
                    )),
                    visibility: .inDevelopment,
                    description: Optional("description"),
                    shortDescription: Optional("shortDescription"),
                    logoUrl: Optional("logoUrl"),
                    categories: [
                        .communication,
                        .communication
                    ],
                    capabilities: [
                        .actions,
                        .actions
                    ],
                    isAgentApp: Optional(true)
                ),
                MarketplaceApp(
                    installed: .installed,
                    id: "id",
                    name: "name",
                    developerOrganizationId: "developerOrganizationId",
                    creator: Optional(DeveloperOrganization(
                        organizationId: "organizationId",
                        name: "name",
                        website: Optional("website"),
                        email: Optional("email"),
                        phone: Optional("phone")
                    )),
                    visibility: .inDevelopment,
                    description: Optional("description"),
                    shortDescription: Optional("shortDescription"),
                    logoUrl: Optional("logoUrl"),
                    categories: [
                        .communication,
                        .communication
                    ],
                    capabilities: [
                        .actions,
                        .actions
                    ],
                    isAgentApp: Optional(true)
                )
            ],
            allAppsCountByFilter: Optional(CountByFilterResult(
                countByVisibility: [
                    .inDevelopment: 1
                ],
                countByCategory: [
                    .communication: 1
                ]
            )),
            installedAppsCountByFilter: Optional(CountByFilterResult(
                countByVisibility: [
                    .inDevelopment: 1
                ],
                countByCategory: [
                    .communication: 1
                ]
            )),
            number: 1,
            size: 1,
            totalElements: 1000000,
            totalPages: 1
        )
        let response = try await client.appDirectory.search(
            request: DirectoryAppsSearchRequest(

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
                  "installed": "INSTALLED",
                  "settings": {
                    "key": "value"
                  },
                  "installationInstructions": "installationInstructions",
                  "instructions": "instructions",
                  "previewUrl": "previewUrl",
                  "links": [
                    {
                      "title": "title",
                      "description": "description",
                      "url": "url"
                    },
                    {
                      "title": "title",
                      "description": "description",
                      "url": "url"
                    }
                  ],
                  "settingsSchema": [
                    {
                      "type": "text",
                      "defaultValue": "defaultValue",
                      "validation": {
                        "pattern": "pattern",
                        "errorMessage": "errorMessage"
                      },
                      "key": "key",
                      "displayName": "displayName",
                      "description": "description",
                      "visibility": "VISIBLE",
                      "required": true
                    },
                    {
                      "type": "text",
                      "defaultValue": "defaultValue",
                      "validation": {
                        "pattern": "pattern",
                        "errorMessage": "errorMessage"
                      },
                      "key": "key",
                      "displayName": "displayName",
                      "description": "description",
                      "visibility": "VISIBLE",
                      "required": true
                    }
                  ],
                  "id": "id",
                  "name": "name",
                  "developerOrganizationId": "developerOrganizationId",
                  "creator": {
                    "organizationId": "organizationId",
                    "name": "name",
                    "website": "website",
                    "email": "email",
                    "phone": "phone"
                  },
                  "visibility": "IN_DEVELOPMENT",
                  "description": "description",
                  "shortDescription": "shortDescription",
                  "logoUrl": "logoUrl",
                  "categories": [
                    "COMMUNICATION",
                    "COMMUNICATION"
                  ],
                  "capabilities": [
                    "ACTIONS",
                    "ACTIONS"
                  ],
                  "isAgentApp": true
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
        let expectedResponse = MarketplaceAppDetail(
            installed: .installed,
            settings: Optional(JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )),
            installationInstructions: Optional("installationInstructions"),
            instructions: Optional("instructions"),
            previewUrl: Optional("previewUrl"),
            links: [
                Link(
                    title: "title",
                    description: Optional("description"),
                    url: "url"
                ),
                Link(
                    title: "title",
                    description: Optional("description"),
                    url: "url"
                )
            ],
            settingsSchema: [
                .text(
                    .init(
                        defaultValue: Optional("defaultValue"),
                        validation: Optional(SettingsSchemaValidation(
                            pattern: "pattern",
                            errorMessage: "errorMessage"
                        )),
                        key: "key",
                        displayName: "displayName",
                        description: Optional("description"),
                        visibility: Optional(.visible),
                        required: Optional(true)
                    )
                ),
                .text(
                    .init(
                        defaultValue: Optional("defaultValue"),
                        validation: Optional(SettingsSchemaValidation(
                            pattern: "pattern",
                            errorMessage: "errorMessage"
                        )),
                        key: "key",
                        displayName: "displayName",
                        description: Optional("description"),
                        visibility: Optional(.visible),
                        required: Optional(true)
                    )
                )
            ],
            id: "id",
            name: "name",
            developerOrganizationId: "developerOrganizationId",
            creator: Optional(DeveloperOrganization(
                organizationId: "organizationId",
                name: "name",
                website: Optional("website"),
                email: Optional("email"),
                phone: Optional("phone")
            )),
            visibility: .inDevelopment,
            description: Optional("description"),
            shortDescription: Optional("shortDescription"),
            logoUrl: Optional("logoUrl"),
            categories: [
                .communication,
                .communication
            ],
            capabilities: [
                .actions,
                .actions
            ],
            isAgentApp: Optional(true)
        )
        let response = try await client.appDirectory.get(
            appId: "appId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getSettingDownloadUrl1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "downloadUrl": "downloadUrl"
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
        let expectedResponse = GetDirectoryAppSettingDownloadUrlResponse(
            downloadUrl: "downloadUrl"
        )
        let response = try await client.appDirectory.getSettingDownloadUrl(
            appId: "appId",
            settingsKey: "settingsKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getSettingUploadUrl1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Data(
                """
                {
                  "uploadUrl": "uploadUrl",
                  "downloadUrl": "downloadUrl"
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
        let expectedResponse = GetDirectoryAppSettingUploadUrlResponse(
            uploadUrl: "uploadUrl",
            downloadUrl: "downloadUrl"
        )
        let response = try await client.appDirectory.getSettingUploadUrl(
            appId: "appId",
            settingsKey: "settingsKey",
            request: .init(
                contentLength: 1,
                contentType: "contentType"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}