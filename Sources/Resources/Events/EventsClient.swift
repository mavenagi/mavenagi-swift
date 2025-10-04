import Foundation

public final class EventsClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create a new event
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

    /// Search events
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
}