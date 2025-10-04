import Foundation

public enum SimulationFilter: String, Codable, Hashable, CaseIterable, Sendable {
    case nonSimulations = "NON_SIMULATIONS"
    case simulations = "SIMULATIONS"
    case all = "ALL"
}