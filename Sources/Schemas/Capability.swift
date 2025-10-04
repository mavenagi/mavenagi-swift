import Foundation

public enum Capability: String, Codable, Hashable, CaseIterable, Sendable {
    case markdown = "MARKDOWN"
    case forms = "FORMS"
    case images = "IMAGES"
    case chartsHighchartsTs = "CHARTS_HIGHCHARTS_TS"
    case async = "ASYNC"
    case oauthButtons = "OAUTH_BUTTONS"
}