import Foundation

public final class CapabilitiesClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Fetch one of an agent's capabilities by its type and reference ID.
    /// 
    /// The response carries the same fields the capability's own API returns, so an Action read
    /// here and an Action read from the Actions API are the same object. Intelligent Fields are the
    /// one exception: their own API also returns the charters referencing the field, which this
    /// endpoint leaves out.
    ///
    /// - Parameter capabilityType: Which kind of capability to fetch.
    /// - Parameter referenceId: The capability's reference ID, unique within its type and app.
    /// - Parameter appId: The app that owns the capability. Defaults to the calling app, which is what an app
    /// managing its own capabilities wants.
    /// - Parameter variantReferenceId: The agent variant to read an intelligent field through, by reference ID.
    /// Required for an intelligent field on an agent with versioned intelligent fields; a
    /// request that omits it there is rejected with reason `VARIANT_REQUIRED`. Otherwise,
    /// if omitted, the agent's only variant is used, as its snapshot has it. When a variant
    /// is named, its staged edits are included: a field with a staged edit is returned at
    /// that edit, a field created in the variant is returned, and a field deleted in the
    /// variant, whether the delete is staged or already in its snapshot, returns 404.
    /// The other capability types aren't versioned and are the same in every variant,
    /// though a named variant must still exist.
    /// - Parameter variantAppId: The app that owns the agent variant. Defaults to the calling app.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getCapability(capabilityType: String, referenceId: String, appId: String? = nil, variantReferenceId: String? = nil, variantAppId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> CapabilityResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/capabilities/\(capabilityType)/\(referenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "variantReferenceId": variantReferenceId.map { .string($0) }, 
                "variantAppId": variantAppId.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: CapabilityResponse.self
        )
    }

    /// Set whether the agent uses a capability, whatever kind it is. This is the publish and
    /// unpublish operation, and it works the same way for every capability type.
    /// 
    /// Everything else about a capability -- its name, its description, and any settings
    /// particular to its kind -- is changed through that capability's own API.
    ///
    /// - Parameter capabilityType: Which kind of capability to update.
    /// - Parameter referenceId: The capability's reference ID, unique within its type and app.
    /// - Parameter appId: The app that owns the capability. Defaults to the calling app.
    /// - Parameter variantReferenceId: The agent variant to stage an intelligent field's status change in, by reference ID.
    /// Required for an intelligent field on an agent with versioned intelligent fields; a
    /// request that omits it there is rejected with reason `VARIANT_REQUIRED`.
    /// The other capability types aren't versioned and are the same in every variant,
    /// though a named variant must still exist.
    /// - Parameter variantAppId: The app that owns the agent variant. Defaults to the calling app.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patchCapability(capabilityType: String, referenceId: String, appId: String? = nil, variantReferenceId: String? = nil, variantAppId: String? = nil, request: Requests.PatchCapabilityByTypeRequest, requestOptions: RequestOptions? = nil) async throws -> CapabilityResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/capabilities/\(capabilityType)/\(referenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "variantReferenceId": variantReferenceId.map { .string($0) }, 
                "variantAppId": variantAppId.map { .string($0) }
            ],
            body: request,
            requestOptions: requestOptions,
            responseType: CapabilityResponse.self
        )
    }

    /// Delete one of an agent's capabilities. The agent stops using it, and it stops being
    /// addressable: a later get, patch or delete of the same capability is a 404, and it no longer
    /// appears in search.
    /// 
    /// With `variantReferenceId`, an intelligent field's delete is staged in that variant instead,
    /// and takes effect when the variant is committed. Until then the agent keeps using the field,
    /// and only a later patch or delete through the same variant is a 404.
    ///
    /// - Parameter capabilityType: Which kind of capability to delete.
    /// - Parameter referenceId: The capability's reference ID, unique within its type and app.
    /// - Parameter appId: The app that owns the capability. Defaults to the calling app.
    /// - Parameter variantReferenceId: The agent variant to stage an intelligent field's delete in, by reference ID.
    /// Required for an intelligent field on an agent with versioned intelligent fields; a
    /// request that omits it there is rejected with reason `VARIANT_REQUIRED`.
    /// The other capability types aren't versioned and are the same in every variant,
    /// though a named variant must still exist.
    /// - Parameter variantAppId: The app that owns the agent variant. Defaults to the calling app.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func deleteCapability(capabilityType: String, referenceId: String, appId: String? = nil, variantReferenceId: String? = nil, variantAppId: String? = nil, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/capabilities/\(capabilityType)/\(referenceId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "variantReferenceId": variantReferenceId.map { .string($0) }, 
                "variantAppId": variantAppId.map { .string($0) }
            ],
            requestOptions: requestOptions
        )
    }

    /// Run one of an agent's capabilities once, as a simulation, and return what it produced.
    /// 
    /// The caller supplies everything the capability reads, so it runs in isolation: no
    /// conversation or agent user has to exist first. The capability is told its mode is
    /// `SIMULATION`, the same as in a test suite run, so an app that honours it can avoid side
    /// effects in real systems. Nothing here runs a capability live.
    /// 
    /// Only actions can be simulated today. Triggers and conversation kickoffs are rejected with a
    /// 400 until they can run as simulations. Intelligent fields cannot be simulated.
    ///
    /// - Parameter capabilityType: Which kind of capability to simulate. Must match the body's `capabilityType`.
    /// - Parameter referenceId: The capability's reference ID, unique within its type and app.
    /// - Parameter appId: The app that owns the capability. Defaults to the calling app.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func simulateCapability(capabilityType: String, referenceId: String, appId: String? = nil, request: CapabilitySimulationInput, requestOptions: RequestOptions? = nil) async throws -> CapabilitySimulationResult {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/capabilities/\(capabilityType)/\(referenceId)/simulate",
            queryParams: [
                "appId": appId.map { .string($0) }
            ],
            body: request,
            requestOptions: requestOptions,
            responseType: CapabilitySimulationResult.self
        )
    }

    /// Search an agent's capabilities of every kind at once, newest first by default.
    /// 
    /// Returns the fields every capability shares. Fetch one by its type and reference ID for the
    /// settings particular to its kind.
    /// 
    /// Sorting by `NAME` or `TYPE` instead orders ascending unless `sortDesc` says otherwise;
    /// `sortDesc` overrides the default either way.
    /// 
    /// Deleted capabilities are never returned.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func searchCapabilities(request: Requests.CapabilitiesSearchRequest, requestOptions: RequestOptions? = nil) async throws -> CapabilitiesSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/capabilities/search",
            body: request,
            requestOptions: requestOptions,
            responseType: CapabilitiesSearchResponse.self
        )
    }

    /// Search the recorded runs of an agent's capabilities, newest first by default. An execution
    /// is one run of one capability for one subject, with its outcome and timing: an Event
    /// Trigger notifying its app, or a Conversation Kickoff running when a conversation started.
    /// 
    /// Pass a conversation in `subjectIds` to get the executions recorded against it. An
    /// `EVENT_CREATED` trigger records the event as its subject, so pass the event's ID to find
    /// those.
    /// 
    /// Results can trail a run by a few seconds. Executions are searchable for 90 days.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func searchCapabilityExecutions(request: Requests.CapabilityExecutionsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> CapabilityExecutionsSearchResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/capabilities/executions/search",
            body: request,
            requestOptions: requestOptions,
            responseType: CapabilityExecutionsSearchResponse.self
        )
    }
}