import Foundation

/// Result type hint used for schema generation, UI, and validation
public enum IntelligentFieldType: String, Codable, Hashable, CaseIterable, Sendable {
    case string = "STRING"
    case multiline = "MULTILINE"
    case multiSelect = "MULTI_SELECT"
    case boolean = "BOOLEAN"
    case number = "NUMBER"
}