import Foundation

/// The behavioral mode for a charter.
/// 
/// - STANDARD: Default. The charter's manual is delivered to the LLM as instructions,
///             concatenated with ancestor charter manuals before delivery.
/// - STRICT_RETURN: When matched, this charter's manual becomes the response: it is returned
///                  verbatim, without invoking the LLM. The charter cannot have children, and
///                  its manual must be non-blank — the manual is the response.
/// 
///                  A STRICT_RETURN charter references nothing: both `knowledgeBaseIds` and
///                  `actionIds` must be empty, and a create or update supplying either is
///                  rejected. With no LLM in the turn there is nothing to consult a knowledge
///                  base or to choose an action.
/// 
///                  A STRICT_RETURN charter is matched exactly like any other charter — same
///                  ordering and mutual-exclusion rules. The only difference is what a match
///                  does: the first matched STRICT_RETURN charter takes over the turn, so its
///                  manual is the whole response and every other matched charter is ignored.
///                  (At most one applies per turn.)
public enum CharterType: String, Codable, Hashable, CaseIterable, Sendable {
    case standard = "STANDARD"
    case strictReturn = "STRICT_RETURN"
}