import Foundation

/// Use this class to access the different functions within the SDK. You can instantiate any number of clients with different configuration that will propagate to these functions.
public final class MavenAGI: Sendable {
    public let actions: ActionsClient
    public let agents: AgentsClient
    public let analytics: AnalyticsClient
    public let appSettings: AppSettingsClient
    public let assets: AssetsClient
    public let commons: CommonsClient
    public let conversation: ConversationClient
    public let customers: CustomersClient
    public let events: EventsClient
    public let inbox: InboxClient
    public let knowledge: KnowledgeClient
    public let organizations: OrganizationsClient
    public let segments: SegmentsClient
    public let translations: TranslationsClient
    public let triggers: TriggersClient
    public let users: UsersClient
    private let httpClient: HTTPClient

    /// Initialize the client with the specified configuration.
    ///
    /// - Parameter baseURL: The base URL to use for requests from the client. If not provided, the default base URL will be used.
    /// - Parameter appId: The username to use for authentication.
    /// - Parameter appSecret: The password to use for authentication.
    /// - Parameter headers: Additional headers to send with each request.
    /// - Parameter timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
    /// - Parameter maxRetries: Maximum number of retries for failed requests. Defaults to 2.
    /// - Parameter urlSession: Custom `URLSession` to use for requests. If not provided, a default session will be created with the specified timeout.
    public convenience init(
        baseURL: String = ApiEnvironment.production.rawValue,
        appId: String? = nil,
        appSecret: String? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        self.init(
            baseURL: baseURL,
            headerAuth: nil,
            bearerAuth: nil,
            basicAuth: .init(username: appId, password: appSecret),
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
    }

    init(
        baseURL: String,
        headerAuth: ClientConfig.HeaderAuth? = nil,
        bearerAuth: ClientConfig.BearerAuth? = nil,
        basicAuth: ClientConfig.BasicAuth? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        let config = ClientConfig(
            baseURL: baseURL,
            headerAuth: headerAuth,
            bearerAuth: bearerAuth,
            basicAuth: basicAuth,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
        self.actions = ActionsClient(config: config)
        self.agents = AgentsClient(config: config)
        self.analytics = AnalyticsClient(config: config)
        self.appSettings = AppSettingsClient(config: config)
        self.assets = AssetsClient(config: config)
        self.commons = CommonsClient(config: config)
        self.conversation = ConversationClient(config: config)
        self.customers = CustomersClient(config: config)
        self.events = EventsClient(config: config)
        self.inbox = InboxClient(config: config)
        self.knowledge = KnowledgeClient(config: config)
        self.organizations = OrganizationsClient(config: config)
        self.segments = SegmentsClient(config: config)
        self.translations = TranslationsClient(config: config)
        self.triggers = TriggersClient(config: config)
        self.users = UsersClient(config: config)
        self.httpClient = HTTPClient(config: config)
    }
}