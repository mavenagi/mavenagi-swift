import Foundation

/// A precondition met while the current time is inside a window.
/// 
/// Accepted only in a charter's precondition; segments, knowledge bases, and actions reject it.
/// 
/// The time checked is when the turn being answered arrives. In chat, the precondition is
/// re-evaluated on every turn, so a conversation that starts inside the window stops matching
/// once a later turn falls outside it. Voice calls do not re-check it on every turn, so a call
/// in progress can keep matching for a while after the window ends.
/// 
/// Each precondition holds one window. Combine windows with a `PreconditionGroup`: OR for a
/// union ("weekdays 9–5 or Saturdays 10–2"), AND with a negated window for an exception
/// ("business hours, but not on Thanksgiving"). Omit the operator to match inside the window,
/// or set it to NOT to match outside it. Any other operator is rejected with a 400.
public struct TimePrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    /// The window the current time must fall inside for the precondition to be met.
    public let window: TimeWindow
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        window: TimeWindow,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.window = window
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.window = try container.decode(TimeWindow.self, forKey: .window)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encode(self.window, forKey: .window)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case window
    }
}