import Foundation

public final class TranslationsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Translate text from one language to another
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func translate(request: TranslationRequest, requestOptions: RequestOptions? = nil) async throws -> TranslationResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/translations/translate",
            body: request,
            requestOptions: requestOptions,
            responseType: TranslationResponse.self
        )
    }
}