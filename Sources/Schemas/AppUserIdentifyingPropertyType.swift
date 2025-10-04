import Foundation

public enum AppUserIdentifyingPropertyType: String, Codable, Hashable, CaseIterable, Sendable {
    case email = "EMAIL"
    case phoneNumber = "PHONE_NUMBER"
}