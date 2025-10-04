import Foundation

public final class AnalyticsClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Retrieves structured conversation data formatted as a table, allowing users to group, filter, and define specific metrics to display as columns.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getConversationTable(request: ConversationTableRequest, requestOptions: RequestOptions? = nil) async throws -> ConversationTableResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/tables/conversations",
            body: request,
            requestOptions: requestOptions,
            responseType: ConversationTableResponse.self
        )
    }

    /// Fetches conversation data visualized in a chart format. Supported chart types include pie chart, date histogram, and stacked bar charts.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getConversationChart(request: ConversationChartRequest, requestOptions: RequestOptions? = nil) async throws -> ChartResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/charts/conversations",
            body: request,
            requestOptions: requestOptions,
            responseType: ChartResponse.self
        )
    }

    /// Retrieves structured feedback data formatted as a table, allowing users to group, filter,  and define specific metrics to display as columns.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getFeedbackTable(request: FeedbackTableRequest, requestOptions: RequestOptions? = nil) async throws -> FeedbackTableResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/tables/feedback",
            body: request,
            requestOptions: requestOptions,
            responseType: FeedbackTableResponse.self
        )
    }

    /// Retrieves structured agent user data formatted as a table, allowing users to group, filter,  and define specific metrics to display as columns.
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getAgentUserTable(request: AgentUserTableRequest, requestOptions: RequestOptions? = nil) async throws -> AgentUserTableResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/tables/agent-users",
            body: request,
            requestOptions: requestOptions,
            responseType: AgentUserTableResponse.self
        )
    }
}