import Foundation

/// An action's declaration about whether executing it causes side effects.
public enum SideEffects: String, Codable, Hashable, CaseIterable, Sendable {
    /// Read-only. Executing it changes nothing.
    case none = "NONE"
    /// Writes something, whether inside Maven or in another system.
    case present = "PRESENT"
}