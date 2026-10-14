import Foundation

/// Why an execution ended the way it did. SUCCESS is the only reason whose status is SUCCESS.
public enum CapabilityExecutionCompletionReason: String, Codable, Hashable, CaseIterable, Sendable {
    /// The app's handler accepted the call. Not a claim that its work finished.
    case success = "SUCCESS"
    /// Never reached the app, such as a refused connection or a 502/503.
    case dispatchError = "DISPATCH_ERROR"
    /// Rate limited by Maven or the app's own upstream.
    case rateLimited = "RATE_LIMITED"
    /// Maven stopped waiting. The app may have completed after that.
    case timeout = "TIMEOUT"
    /// The app's handler failed or returned an error; its side effects may or may not have run.
    case handlerError = "HANDLER_ERROR"
    /// The app does not implement this hook.
    case noHandler = "NO_HANDLER"
    /// Authorization for the app or capability version failed.
    case forbidden = "FORBIDDEN"
    /// Never reported back. The run was still going long after any live one would have
    /// finished, so the process running it went away first. The app may or may not have been
    /// called.
    case outcomeUnknown = "OUTCOME_UNKNOWN"
    /// The app reported a failure and said running it again is safe.
    case appRetryable = "APP_RETRYABLE"
    /// The app reported a failure and did not ask for it to be run again.
    case appRejected = "APP_REJECTED"
}