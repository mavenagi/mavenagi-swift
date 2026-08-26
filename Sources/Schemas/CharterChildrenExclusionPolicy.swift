import Foundation

/// Controls whether this charter's direct children mutually exclude each other when more than
/// one of them matches a turn. Set on the parent (group) charter; it has no effect on a charter
/// with no children.
/// 
/// - DEFAULT: Standard behavior. A parent's children are mutually exclusive only when all of that
///            parent's children are leaves — when they compete, only the highest-priority child
///            (lowest userRank) is kept. If any child is itself a group (has children of its
///            own), none of the parent's children are excluded.
/// - ALLOW_OVERLAP: This charter's children never mutually exclude each other. Every child that
///                  matches is kept.
public enum CharterChildrenExclusionPolicy: String, Codable, Hashable, CaseIterable, Sendable {
    case `default` = "DEFAULT"
    case allowOverlap = "ALLOW_OVERLAP"
}