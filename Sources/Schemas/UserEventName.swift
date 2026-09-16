import Foundation

public enum UserEventName: String, Codable, Hashable, CaseIterable, Sendable {
    /// A button click occurred
    case buttonClicked = "BUTTON_CLICKED"
    /// A link was clicked
    case linkClicked = "LINK_CLICKED"
    /// The chat window was opened
    case chatOpened = "CHAT_OPENED"
    /// The chat window was closed
    case chatClosed = "CHAT_CLOSED"
    /// A text was inserted into a field
    case textInserted = "TEXT_INSERTED"
    /// A CSAT rating was submitted
    case csatSubmitted = "CSAT_SUBMITTED"
    /// A page or screen was viewed. Record which one in `pageInfo`.
    case pageViewed = "PAGE_VIEWED"
    /// A suggested or popular question was clicked instead of being typed
    case suggestionClicked = "SUGGESTION_CLICKED"
    /// The user ended the conversation
    case conversationEnded = "CONVERSATION_ENDED"
    /// The user asked to be transferred to a human agent
    case handoffRequested = "HANDOFF_REQUESTED"
    /// The user opened a support ticket or case
    case ticketCreated = "TICKET_CREATED"
    /// Text from a response was copied
    case textCopied = "TEXT_COPIED"
    /// Content was translated into another language
    case contentTranslated = "CONTENT_TRANSLATED"
    /// A search query was submitted
    case searchSubmitted = "SEARCH_SUBMITTED"
    /// A search result was opened
    case searchResultClicked = "SEARCH_RESULT_CLICKED"
    /// A help article or knowledge document was read
    case articleViewed = "ARTICLE_VIEWED"
    /// The user uploaded a file or attachment
    case fileUploaded = "FILE_UPLOADED"
    /// The user downloaded a file or attachment
    case fileDownloaded = "FILE_DOWNLOADED"
    /// The user began filling out a form
    case formStarted = "FORM_STARTED"
    /// A form was submitted
    case formSubmitted = "FORM_SUBMITTED"
    /// The user left a form without submitting it
    case formAbandoned = "FORM_ABANDONED"
    /// The user entered a multi-step flow, such as onboarding or checkout
    case flowStarted = "FLOW_STARTED"
    /// The user finished one step of a multi-step flow
    case flowStepCompleted = "FLOW_STEP_COMPLETED"
    /// The user finished a multi-step flow
    case flowCompleted = "FLOW_COMPLETED"
    /// The user left a multi-step flow partway through. Pair with an `EVENT_CREATED` trigger to follow up on an onboarding or checkout that was never finished. Name the flow and the step it stopped on in `contextInfo.additionalData`.
    case flowAbandoned = "FLOW_ABANDONED"
    /// The user created an account
    case accountCreated = "ACCOUNT_CREATED"
    /// The user signed in
    case signedIn = "SIGNED_IN"
    /// The user signed out
    case signedOut = "SIGNED_OUT"
    /// The user started a subscription or plan
    case subscriptionStarted = "SUBSCRIPTION_STARTED"
    /// The user cancelled a subscription or plan
    case subscriptionCancelled = "SUBSCRIPTION_CANCELLED"
    /// The user placed an order
    case orderPlaced = "ORDER_PLACED"
    /// The user cancelled an order
    case orderCancelled = "ORDER_CANCELLED"
    /// A payment the user attempted did not go through
    case paymentFailed = "PAYMENT_FAILED"
    /// The user was shown an error
    case errorDisplayed = "ERROR_DISPLAYED"
}