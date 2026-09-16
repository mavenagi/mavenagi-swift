import Foundation

/// Deprecated. Superseded by charters, which determine agent behavior per turn.
public enum LlmPersona: String, Codable, Hashable, CaseIterable, Sendable {
    case casualBuddy = "CASUAL_BUDDY"
    case empatheticSupporter = "EMPATHETIC_SUPPORTER"
    case formalProfessional = "FORMAL_PROFESSIONAL"
    case conciseExpert = "CONCISE_EXPERT"
    case enthusiasticHelper = "ENTHUSIASTIC_HELPER"
    case patientEducator = "PATIENT_EDUCATOR"
    case pirate = "PIRATE"
}