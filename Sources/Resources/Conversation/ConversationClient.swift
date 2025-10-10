import Foundation

public final class ConversationClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Initialize a new conversation. 
    /// Only required if the ask request wishes to supply conversation level data or when syncing to external systems.
    /// 
    /// Conversations can not be modified using this API. If the conversation already exists then the existing conversation will be returned.
    /// 
    /// After initialization,
    /// - metadata can be changed using the `updateConversationMetadata` API.
    /// - messages can be added to the conversation with the `appendNewMessages` or `ask` APIs.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func initialize(request: ConversationRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationResponse.self
        )
    }

    /// Update mutable conversation fields. 
    /// 
    /// The `appId` field can be provided to update a conversation owned by a different app. 
    /// All other fields will overwrite the existing value on the conversation only if provided.
    ///
    /// - Parameter conversationId: The ID of the conversation to patch
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func patch(conversationId: String, request: ConversationPatchRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/conversations/\(conversationId)",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationResponse.self
        )
    }

    /// Get a conversation
    ///
    /// - Parameter conversationId: The ID of the conversation to get
    /// - Parameter appId: The App ID of the conversation to get. If not provided the ID of the calling app will be used.
    /// - Parameter translationLanguage: The language to translate the conversation analysis into
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(conversationId: String, appId: String? = nil, translationLanguage: String? = nil, requestOptions: RequestOptions? = nil) async throws -> ConversationResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/conversations/\(conversationId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "translationLanguage": translationLanguage.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: ConversationResponse.self
        )
    }

    /// Wipes a conversation of all user data. 
    /// The conversation ID will still exist and non-user specific data will still be retained. 
    /// Attempts to modify or add messages to the conversation will throw an error. 
    /// 
    /// Simulation conversations will no longer be visible in search results nor metrics. 
    /// Non-simulation conversations will remain visible - they can not be fully removed from the system.
    /// 
    /// <Warning>This is a destructive operation and cannot be undone. <br/><br/>
    /// The exact fields cleared include: the conversation subject, userRequest, agentResponse. 
    /// As well as the text response, followup questions, and backend LLM prompt of all messages.</Warning>
    ///
    /// - Parameter conversationId: The ID of the conversation to delete
    /// - Parameter appId: The App ID of the conversation to delete. If not provided the ID of the calling app will be used.
    /// - Parameter reason: The reason for deleting the conversation. This message will replace all user messages in the conversation.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func delete(conversationId: String, appId: String? = nil, reason: String, requestOptions: RequestOptions? = nil) async throws -> Void {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/v1/conversations/\(conversationId)",
            queryParams: [
                "appId": appId.map { .string($0) }, 
                "reason": .string(reason)
            ],
            requestOptions: requestOptions
        )
    }

    /// Append messages to an existing conversation. The conversation must be initialized first. If a message with the same ID already exists, it will be ignored. Messages do not allow modification.
    ///
    /// - Parameter conversationId: The ID of the conversation to append messages to
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func appendNewMessages(conversationId: String, request: [ConversationMessageRequest], requestOptions: RequestOptions? = nil) async throws -> ConversationResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/messages",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationResponse.self
        )
    }

    /// Get an answer from Maven for a given user question. If the user question or its answer already exists, 
    /// they will be reused and will not be updated. Messages do not allow modification once generated. 
    /// 
    /// Concurrency Behavior:
    /// - If another API call is made for the same user question while a response is mid-stream, partial answers may be returned.
    /// - The second caller will receive a truncated or partial response depending on where the first stream is in its processing. The first caller's stream will remain unaffected and continue delivering the full response.
    /// 
    /// Known Limitation:
    /// - The API does not currently expose metadata indicating whether a response or message is incomplete. This will be addressed in a future update.
    ///
    /// - Parameter conversationId: The ID of a new or existing conversation to use as context for the question
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func ask(conversationId: String, request: AskRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/ask",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationResponse.self
        )
    }

    /// Get an answer from Maven for a given user question with a streaming response. The response will be sent as a stream of events. 
    /// The text portions of stream responses should be concatenated to form the full response text. 
    /// Action and metadata events should overwrite past data and do not need concatenation.
    /// 
    /// If the user question or its answer already exists, they will be reused and will not be updated. 
    /// Messages do not allow modification once generated.
    ///         
    /// Concurrency Behavior:
    /// - If another API call is made for the same user question while a response is mid-stream, partial answers may be returned.
    /// - The second caller will receive a truncated or partial response depending on where the first stream is in its processing. The first caller's stream will remain unaffected and continue delivering the full response.
    /// 
    /// Known Limitation:
    /// - The API does not currently expose metadata indicating whether a response or message is incomplete. This will be addressed in a future update.
    ///
    /// - Parameter conversationId: The ID of a new or existing conversation to use as context for the question
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func askStream(conversationId: String, request: AskRequest, requestOptions: RequestOptions? = nil) async throws -> JSONValue {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/ask_stream",
            body: request,
            requestOptions: requestOptions,
            responseType: JSONValue.self
        )
    }

    /// Generate a structured object response based on a provided schema and user prompt with a streaming response. 
    /// The response will be sent as a stream of events containing text, start, and end events.
    /// The text portions of stream responses should be concatenated to form the full response text.
    /// 
    /// If the user question and object response already exist, they will be reused and not updated.
    /// 
    /// Concurrency Behavior:
    /// - If another API call is made for the same user question while a response is mid-stream, partial answers may be returned.
    /// - The second caller will receive a truncated or partial response depending on where the first stream is in its processing. The first caller's stream will remain unaffected and continue delivering the full response.
    /// 
    /// Known Limitations:
    /// - Schema enforcement is best-effort and may not guarantee exact conformity.
    /// - The API does not currently expose metadata indicating whether a response or message is incomplete. This will be addressed in a future update.
    ///
    /// - Parameter conversationId: The ID of a new or existing conversation to use as context for the object generation request
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func askObjectStream(conversationId: String, request: AskObjectRequest, requestOptions: RequestOptions? = nil) async throws -> JSONValue {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/ask_object_stream",
            body: request,
            requestOptions: requestOptions,
            responseType: JSONValue.self
        )
    }

    /// Uses an LLM flow to categorize the conversation. Experimental.
    ///
    /// - Parameter conversationId: The ID of the conversation to categorize
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func categorize(conversationId: String, requestOptions: RequestOptions? = nil) async throws -> CategorizationResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/categorize",
            requestOptions: requestOptions,
            responseType: CategorizationResponse.self
        )
    }

    /// Update feedback or create it if it doesn't exist
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createFeedback(request: FeedbackRequest, requestOptions: RequestOptions? = nil) async throws -> Feedback {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/feedback",
            body: request,
            requestOptions: requestOptions,
            responseType: Feedback.self
        )
    }

    /// Submit a filled out action form
    ///
    /// - Parameter conversationId: The ID of a conversation the form being submitted belongs to
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func submitActionForm(conversationId: String, request: SubmitActionFormRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/submit-form",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationResponse.self
        )
    }

    /// Replaced by `updateConversationMetadata`. 
    /// 
    /// Adds metadata to an existing conversation. If a metadata field already exists, it will be overwritten.
    ///
    /// - Parameter conversationId: The ID of a conversation the metadata being added belongs to
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func addConversationMetadata(conversationId: String, request: [String: String], requestOptions: RequestOptions? = nil) async throws -> [String: String] {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/\(conversationId)/metadata",
            body: request,
            requestOptions: requestOptions,
            responseType: [String: String].self
        )
    }

    /// Update metadata supplied by the calling application for an existing conversation. 
    /// Does not modify metadata saved by other apps.
    /// 
    /// If a metadata field already exists for the calling app, it will be overwritten. 
    /// If it does not exist, it will be added. Will not remove metadata fields.
    /// 
    /// Returns all metadata saved by any app on the conversation.
    ///
    /// - Parameter conversationId: The ID of the conversation to modify metadata for
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func updateConversationMetadata(conversationId: String, request: UpdateMetadataRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationMetadata {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/conversations/\(conversationId)/metadata",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationMetadata.self
        )
    }

    /// Search conversations
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func search(request: ConversationsSearchRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationsResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/search",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationsResponse.self
        )
    }

    /// Deliver a message to a user or conversation.
    /// 
    /// <Warning>
    /// Currently, messages can only be successfully delivered to conversations with the `ASYNC` capability that are `open`. 
    /// User message delivery is not yet supported.
    /// </Warning>
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func deliverMessage(request: DeliverMessageRequest, requestOptions: RequestOptions? = nil) async throws -> DeliverMessageResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/conversations/deliver-message",
            body: request,
            requestOptions: requestOptions,
            responseType: DeliverMessageResponse.self
        )
    }
}