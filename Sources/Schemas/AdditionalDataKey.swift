import Foundation

/// A shared vocabulary of `contextInfo.additionalData` keys, for any event from any sender. Events
/// that carry the same kind of information under the same key share a shape, so one event
/// condition or report works across all of them. Using these keys is encouraged, not required:
/// any other key is still accepted.
/// 
/// Values are strings, like every value in `additionalData`: numbers and booleans as their text
/// (`3`, `true`), anything structured as JSON.
public enum AdditionalDataKey: String, Codable, Hashable, CaseIterable, Sendable {
    /// The new value of whatever changed. Absent when undetermined. Maven sets it on `INTELLIGENT_FIELD_VALUE_CHANGED`.
    case value
    /// The value before the change. Absent when it was undetermined or there was none. Maven sets it on `INTELLIGENT_FIELD_VALUE_CHANGED`.
    case previousValue
    /// The name of the thing acted on, such as a form, flow, file or plan.
    case name
    /// The step reached within a flow or form, as its name or number.
    case step
    /// Why it happened, such as why a handoff was requested or a subscription cancelled.
    case reason
    /// A machine-readable code for the error, for events that report a failure.
    case errorCode
    /// A human-readable description of the error, for events that report a failure.
    case errorMessage
    /// The URL involved, such as the target of a clicked link.
    case url
    /// The text searched for.
    case query
    /// The 1-based position of the chosen item in a list, such as a search result or a suggestion.
    case position
    /// A monetary amount, as a decimal number in `currency`.
    case amount
    /// The ISO 4217 code of `amount`'s currency, such as `USD`.
    case currency
    /// The channel a message went out on, such as `email`, `sms` or `push`.
    case channel
    /// The language content was translated from, as a BCP 47 tag.
    case sourceLanguage
    /// The language content was translated into, as a BCP 47 tag.
    case targetLanguage
    /// The MIME type of the file involved.
    case mimeType
    /// The size of the file involved, in bytes.
    case sizeBytes
}