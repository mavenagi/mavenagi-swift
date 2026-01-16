import Foundation

public enum EventField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CREATED_AT"
    case eventName = "EVENT_NAME"
    case eventType = "EVENT_TYPE"
    case app = "APP"
    case sessionId = "SESSION_ID"
    case sourceType = "SOURCE_TYPE"
    case sourceLanguageCode = "SOURCE_LANGUAGE_CODE"
    case sourceDeviceType = "SOURCE_DEVICE_TYPE"
    case sourceDeviceName = "SOURCE_DEVICE_NAME"
    case sourceBrowserType = "SOURCE_BROWSER_TYPE"
    case sourceBrowserName = "SOURCE_BROWSER_NAME"
    case sourceGeoCity = "SOURCE_GEO_CITY"
    case sourceGeoState = "SOURCE_GEO_STATE"
    case sourceGeoCountry = "SOURCE_GEO_COUNTRY"
    case userReferenceId = "USER_REFERENCE_ID"
    case agentUserId = "AGENT_USER_ID"
    case timestamp = "TIMESTAMP"
}