import Foundation

/// Why a request was rejected. Values are UPPER_SNAKE_CASE, at most 63 characters. New values may be added, so treat an unrecognized one as a generic error. All current values come from agent-variant operations.
public enum ErrorReason: String, Codable, Hashable, CaseIterable, Sendable {
    /// The variant is receiving live traffic, so it can't be edited. Fork a working variant and edit that instead.
    case variantLive = "VARIANT_LIVE"
    /// The variant is archived or deleted.
    case variantNotActive = "VARIANT_NOT_ACTIVE"
    /// The traffic config changed since it was last read. Re-read it and retry.
    case staleTrafficRevision = "STALE_TRAFFIC_REVISION"
    /// The variant's working set changed since it was last read (its `workingSetRevision` moved). Re-read it and retry.
    case staleWorkingSet = "STALE_WORKING_SET"
    /// The variant's staged edits don't change its configuration, so there is nothing to commit.
    case nothingToCommit = "NOTHING_TO_COMMIT"
    /// The ID requested for a new variant is already taken.
    case variantAlreadyExists = "VARIANT_ALREADY_EXISTS"
    /// The agent is at its limit of ACTIVE variants, so no variant can be created, forked, committed or set back to ACTIVE. Archive or delete one first.
    case variantLimitReached = "VARIANT_LIMIT_REACHED"
    /// The variant is receiving live traffic, so it can't be archived or deleted. Move its traffic elsewhere first.
    case cannotArchiveLiveVariant = "CANNOT_ARCHIVE_LIVE_VARIANT"
    /// A traffic rule, a simulation or an eval run names a variant with staged edits. Publish or discard them first.
    case variantHasStagedEdits = "VARIANT_HAS_STAGED_EDITS"
    /// The entity type is versioned on this agent, so the request must name the agent variant to read or write. Pass the variant's reference ID, and its owning app where the endpoint takes one; a request that names none is rejected.
    case variantRequired = "VARIANT_REQUIRED"
    /// The write would change an intelligent field's `validationType` in an agent variant. A field keeps its type across variants; to use a different type, create a new field.
    case intelligentFieldTypeChanged = "INTELLIGENT_FIELD_TYPE_CHANGED"
    /// The working set holds staged edits of an entity type or agent setting that isn't versioned for the agent now (see `agents.getVersionedEntityTypes`), left from before its versioning was turned off - note that this can only happen in case of a reverted rollout. Committing would  publish them. Discard them with `discardWorkingSetEdits`' `entityType` or `agentSetting`, then retry.
    case workingSetHasUnversionedEdits = "WORKING_SET_HAS_UNVERSIONED_EDITS"
}