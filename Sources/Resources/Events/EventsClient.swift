import Foundation

public final class EventsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create a new event. Events are immutable, so a create that reuses the `referenceId` of an
    /// existing event in the same app is rejected with a 409 and leaves that event unchanged.
    /// 
    /// <Note>**Required permission:** `ask:agent`. An event with `executionMode: SIMULATION` also needs `create:simulations`.</Note>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func create(request: EventRequest, requestOptions: RequestOptions? = nil) async throws -> EventResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/events",
            body: request,
            requestOptions: requestOptions,
            responseType: EventResponse.self
        )
    }

    /// Search events.
    /// 
    /// Pagination is limited to the first 10,000 matching events: `(page + 1) * size` must not
    /// exceed 10,000, and a request beyond that is rejected with a 400. Narrow the filter to reach
    /// later results.
    /// 
    /// <Note>**Required permission:** `read:events`</Note>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: EventsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> EventsSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/events/search",
            body: request,
            requestOptions: requestOptions,
            responseType: EventsSearchResponse.self
        )
    }

    /// Retrieve details of a specific Event item by its ID.
    /// 
    /// <Note>**Required permission:** `read:events`</Note>
    ///
    /// - Parameter eventId: The ID of the Event to get.
    /// - Parameter appId: The App ID of the Event to retrieve
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(eventId: String, appId: String, requestOptions: RequestOptions? = nil) async throws -> EventResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/events/\(eventId)",
            queryParams: [
                "appId": .string(appId)
            ],
            requestOptions: requestOptions,
            responseType: EventResponse.self
        )
    }

    /// Export events to a CSV file.
    /// 
    /// This will output a summary of each event that matches the supplied filter. Only the first 10,000 matching events can be exported: `(page + 1) * size` must not exceed 10,000, and a request beyond that is rejected with a 400. For most use cases it is recommended to use the search API instead and convert the JSON response to your desired format. The CSV format may change over time and should not be relied upon by code consumers.
    /// 
    /// <Note>**Required permission:** `read:events`</Note>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func export(request: EventsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> Data {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/events/export",
            body: request,
            requestOptions: requestOptions,
            responseType: Data.self
        )
    }
}