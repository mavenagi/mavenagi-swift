import Foundation

public enum CustomerField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CreatedAt"
    case name = "Name"
}