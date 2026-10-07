import Foundation

public final class TriggersClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Deprecated. Use `POST /v1/capabilities/search`, which searches every kind of capability
    /// at once. It returns the fields every capability shares rather than the whole Event
    /// Trigger; fetch one by its kind and reference ID for the rest.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: EventTriggersSearchRequest, requestOptions: RequestOptions? = nil) async throws -> EventTriggersSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/triggers",
            body: request,
            requestOptions: requestOptions,
            responseType: EventTriggersSearchResponse.self
        )
    }

    /// Update an event trigger or create it if it doesn't exist.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: EventTriggerRequest, requestOptions: RequestOptions? = nil) async throws -> EventTriggerResponse {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/triggers",
            body: request,
            requestOptions: requestOptions,
            responseType: EventTriggerResponse.self
        )
    }

    /// Deprecated. Use `GET /v1/capabilities/TRIGGER/{referenceId}`, which returns this same
    /// object for a trigger and the equivalent for every other kind of capability.
    /// 
    /// Get an event trigger by its supplied ID
    ///
    /// - Parameter triggerReferenceId: The reference ID of the event trigger to get. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(triggerReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> EventTriggerResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/triggers/\(triggerReferenceId)",
            requestOptions: requestOptions,
            responseType: EventTriggerResponse.self
        )
    }

    /// Deprecated. Use `DELETE /v1/capabilities/TRIGGER/{referenceId}`, which deletes any kind
    /// of capability the same way.
    /// 
    /// Delete an event trigger
    ///
    /// - Parameter triggerReferenceId: The reference ID of the event trigger to delete. All other entity ID fields are inferred from the request.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(triggerReferenceId: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/triggers/\(triggerReferenceId)",
            requestOptions: requestOptions
        )
    }

    /// Updates an event trigger. `enabled` and `condition` are the editable fields.
    /// 
    /// `PATCH /v1/capabilities/TRIGGER/{referenceId}` with a `status` also turns a trigger on and
    /// off, the same way it publishes and unpublishes any kind of capability.
    ///
    /// - Parameter triggerReferenceId: The reference ID of the event trigger to update. All other entity ID fields are inferred from the request.
    /// - Parameter appId: The App ID of the trigger to update. If not provided, the ID of the calling app will be used.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func partialUpdate(triggerReferenceId: String, appId: String? = nil, request: Requests.PartialUpdateRequest, requestOptions: RequestOptions? = nil) async throws -> EventTriggerResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/triggers/\(triggerReferenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            body: request,
            requestOptions: requestOptions,
            responseType: EventTriggerResponse.self
        )
    }
}