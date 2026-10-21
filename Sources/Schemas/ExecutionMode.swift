import Foundation

/// The silo a record lives in. LIVE is real end-user data. SIMULATION is a test or
/// simulation run, kept apart from LIVE data: a simulation record is only ever linked to
/// other simulation records.
public enum ExecutionMode: String, Codable, Hashable, CaseIterable, Sendable {
    case live = "LIVE"
    case simulation = "SIMULATION"
}