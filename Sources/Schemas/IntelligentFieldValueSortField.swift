import Foundation

/// Fields that can be used to sort intelligent field value search results
public enum IntelligentFieldValueSortField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CREATED_AT"
}