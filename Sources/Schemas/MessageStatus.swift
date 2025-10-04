import Foundation

/// The delivery status of the message.
/// 
/// * `SENDING`: The message is being streamed to the user.
/// * `SENT`: The message has been sent to the user.
/// * `REJECTED`: The message was rejected by the system.
/// * `CANCELED`: The message was canceled by the user before streaming was complete.
/// * `FAILED`: The message generating or sending encountered an error.
/// * `UNKNOWN`: The message status is unknown.
public enum MessageStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case sending = "SENDING"
    case sent = "SENT"
    case rejected = "REJECTED"
    case canceled = "CANCELED"
    case failed = "FAILED"
    case unknown = "UNKNOWN"
}