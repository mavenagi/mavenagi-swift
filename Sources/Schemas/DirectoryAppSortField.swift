import Foundation

/// The field a directory search sorts by.
public enum DirectoryAppSortField: String, Codable, Hashable, CaseIterable, Sendable {
    /// The app's id.
    case id
    /// The app's display name.
    case name
    /// When the app was created.
    case createdAt
    /// PUBLIC, PRIVATE or IN_DEVELOPMENT.
    case visibility
    /// The organization that owns the app.
    case developerOrganizationId
}