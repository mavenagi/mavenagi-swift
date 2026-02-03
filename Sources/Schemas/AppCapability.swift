import Foundation

public enum AppCapability: String, Codable, Hashable, CaseIterable, Sendable {
    case actions = "ACTIONS"
    case bailout = "BAILOUT"
    case knowledgeBases = "KNOWLEDGE_BASES"
    case personalization = "PERSONALIZATION"
    case triggers = "TRIGGERS"
}