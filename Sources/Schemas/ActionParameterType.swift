import Foundation

public enum ActionParameterType: String, Codable, Hashable, CaseIterable, Sendable {
    /// String parameter type for text input.
    case string = "STRING"
    /// A long string parameter type for text input. Will be rendered as a textarea when used in a form.
    case multiline = "MULTILINE"
    /// Boolean parameter type for true/false values.
    case boolean = "BOOLEAN"
    /// Number parameter type for numeric values.
    case number = "NUMBER"
    /// Date-time parameter type (ISO-8601, e.g. 2018-11-13T20:20:39Z)
    case datetime = "DATETIME"
    /// Date parameter type (ISO-8601, e.g. 2018-11-13)
    case date = "DATE"
    /// Time parameter type (ISO-8601, e.g. 20:20:39)
    case time = "TIME"
    /// Email parameter type; must be a valid email address
    case email = "EMAIL"
    /// Schema parameter type for complex structured data that adheres to a JSON schema definition. When this type is used this should be the only action parameter (all other parameters should be omitted), the `schema` field must be set and `enumOptions` should not be used.
    case schema = "SCHEMA"
    /// File parameter type for file uploads.
    case file = "FILE"
    /// OAuth authorization parameter type used to pass an access token at execution time. When this type is used it should be the only action parameter. This parameter is not sent to the LLM or shown on forms.
    case oauth = "OAUTH"
}