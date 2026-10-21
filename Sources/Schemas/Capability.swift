import Foundation

public enum Capability: String, Codable, Hashable, CaseIterable, Sendable {
    case markdown = "MARKDOWN"
    case forms = "FORMS"
    case images = "IMAGES"
    /// Shown in Agent Designer as "Charts".
    case chartsHighchartsTs = "CHARTS_HIGHCHARTS_TS"
    /// Shown in Agent Designer as "Async messaging".
    case async = "ASYNC"
    case oauthButtons = "OAUTH_BUTTONS"
}