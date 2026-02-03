import Foundation

public enum AppCategory: String, Codable, Hashable, CaseIterable, Sendable {
    case communication = "COMMUNICATION"
    case customerSupport = "CUSTOMER_SUPPORT"
    case dataStorage = "DATA_STORAGE"
    case internalTools = "INTERNAL_TOOLS"
    case knowledge = "KNOWLEDGE"
    case projectManagement = "PROJECT_MANAGEMENT"
    case voice = "VOICE"
}