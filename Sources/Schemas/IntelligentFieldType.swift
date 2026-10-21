import Foundation

/// Result type hint used for schema generation, UI, and validation. In Agent Designer, "Text" saves as `MULTILINE`, "Select" is `STRING` (or `NUMBER` when every option is numeric) with `enumOptions`, and "Multi-Select" is `MULTI_SELECT`.
public enum IntelligentFieldType: String, Codable, Hashable, CaseIterable, Sendable {
    /// A single short string value.
    case string = "STRING"
    /// A single string value expected to run to several lines, such as a summary.
    case multiline = "MULTILINE"
    /// A list of string values, normally paired with `enumOptions` to constrain the choices.
    case multiSelect = "MULTI_SELECT"
    /// A true/false value.
    case boolean = "BOOLEAN"
    /// A numeric value.
    case number = "NUMBER"
}