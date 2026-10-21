import Foundation

/// The kind of relationship (edge) between two entities. Names the edge,
/// not the node — `EntityId` already carries the node type.
/// 
/// * `SPAWN_FROM`: the entity this one was spawned from. Shown in Agent Designer as "Started from".
/// * `SPAWN_TO`: the entities that were spawned from this one. Shown in Agent Designer as "Linked to".
public enum RelationshipType: String, Codable, Hashable, CaseIterable, Sendable {
    case spawnFrom = "SPAWN_FROM"
    case spawnTo = "SPAWN_TO"
}