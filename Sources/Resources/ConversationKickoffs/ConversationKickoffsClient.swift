import Foundation

public final class ConversationKickoffsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Register or update one of the calling app's Conversation Kickoffs for this agent. An app may
    /// hold multiple independent installs, and any number of an agent's kickoffs may run at once.
    /// 
    /// A newly installed kickoff starts inactive, so installing one never changes an agent's
    /// behaviour on its own. Updating an existing one rewrites its name and description and leaves
    /// its status alone, so re-registering on every install refresh never deactivates a kickoff
    /// that is already live. Use the capability APIs to activate it, and to read, search or delete
    /// it afterwards.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createOrUpdate(request: Requests.CreateConversationKickoffRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationKickoff {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/conversation-kickoffs",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationKickoff.self
        )
    }
}