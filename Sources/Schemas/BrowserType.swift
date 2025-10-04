import Foundation

public enum BrowserType: String, Codable, Hashable, CaseIterable, Sendable {
    case chrome = "CHROME"
    case firefox = "FIREFOX"
    case safari = "SAFARI"
    case opera = "OPERA"
    case edge = "EDGE"
    case other = "OTHER"
}