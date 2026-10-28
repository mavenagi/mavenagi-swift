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
    /// A text was inserted into a field. Shown in Agent Designer as "Inserted".
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
    /// A search query was submitted. `contextInfo.additionalData` carries `query` (see `AdditionalDataKey`).
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
    /// The user created an account. `contextInfo.additionalData` carries `method` (see `AdditionalDataKey`).
    case accountCreated = "ACCOUNT_CREATED"
    /// The user signed in. `contextInfo.additionalData` carries `method` (see `AdditionalDataKey`).
    case signedIn = "SIGNED_IN"
    /// The user signed out
    case signedOut = "SIGNED_OUT"
    /// The user started a subscription or plan
    case subscriptionStarted = "SUBSCRIPTION_STARTED"
    /// The user cancelled a subscription or plan
    case subscriptionCancelled = "SUBSCRIPTION_CANCELLED"
    /// The user placed an order. `contextInfo.additionalData` carries `transactionId`, `amount`, `currency`, `coupon`, `shipping`, `tax`, `customerType` and `items` (see `AdditionalDataKey`).
    case orderPlaced = "ORDER_PLACED"
    /// The user cancelled an order
    case orderCancelled = "ORDER_CANCELLED"
    /// A payment the user attempted did not go through
    case paymentFailed = "PAYMENT_FAILED"
    /// The user was shown an error
    case errorDisplayed = "ERROR_DISPLAYED"
    /// The user was shown an ad. `contextInfo.additionalData` carries `adPlatform`, `adSource`, `adFormat`, `adUnitName`, `amount` and `currency` (see `AdditionalDataKey`).
    case adImpression = "AD_IMPRESSION"
    /// The user earned points, credits or another in-app currency. `contextInfo.additionalData` carries `virtualCurrencyName` and `virtualCurrencyAmount` (see `AdditionalDataKey`).
    case earnVirtualCurrency = "EARN_VIRTUAL_CURRENCY"
    /// The user joined a group, team or community. `contextInfo.additionalData` carries `groupId` (see `AdditionalDataKey`).
    case joinGroup = "JOIN_GROUP"
    /// The user selected a piece of content, such as a video or a card. `contextInfo.additionalData` carries `contentType` and `contentId` (see `AdditionalDataKey`).
    case selectContent = "SELECT_CONTENT"
    /// The user shared content. `contextInfo.additionalData` carries `method`, `contentType` and `contentId` (see `AdditionalDataKey`).
    case share = "SHARE"
    /// The user spent points, credits or another in-app currency. `contextInfo.additionalData` carries `virtualCurrencyName`, `virtualCurrencyAmount` and `name` (see `AdditionalDataKey`).
    case spendVirtualCurrency = "SPEND_VIRTUAL_CURRENCY"
    /// The user was shown a list of products, such as category or search results. `contextInfo.additionalData` carries `itemListId`, `itemListName` and `items` (see `AdditionalDataKey`).
    case viewItemList = "VIEW_ITEM_LIST"
    /// The user selected a product from a list. `contextInfo.additionalData` carries `itemListId`, `itemListName` and `items` (see `AdditionalDataKey`).
    case selectItem = "SELECT_ITEM"
    /// The user viewed a product. `contextInfo.additionalData` carries `amount`, `currency` and `items` (see `AdditionalDataKey`).
    case viewItem = "VIEW_ITEM"
    /// The user was shown a promotion. `contextInfo.additionalData` carries `promotionId`, `promotionName`, `creativeName`, `creativeSlot` and `items` (see `AdditionalDataKey`).
    case viewPromotion = "VIEW_PROMOTION"
    /// The user selected a promotion. `contextInfo.additionalData` carries `promotionId`, `promotionName`, `creativeName`, `creativeSlot` and `items` (see `AdditionalDataKey`).
    case selectPromotion = "SELECT_PROMOTION"
    /// The user added a product to a wishlist. `contextInfo.additionalData` carries `amount`, `currency` and `items` (see `AdditionalDataKey`).
    case addToWishlist = "ADD_TO_WISHLIST"
    /// The user added a product to their cart. `contextInfo.additionalData` carries `amount`, `currency` and `items` (see `AdditionalDataKey`).
    case addToCart = "ADD_TO_CART"
    /// The user removed a product from their cart. `contextInfo.additionalData` carries `amount`, `currency` and `items` (see `AdditionalDataKey`).
    case removeFromCart = "REMOVE_FROM_CART"
    /// The user viewed their cart. `contextInfo.additionalData` carries `amount`, `currency` and `items` (see `AdditionalDataKey`).
    case viewCart = "VIEW_CART"
    /// The user started checkout. `contextInfo.additionalData` carries `amount`, `currency`, `coupon` and `items` (see `AdditionalDataKey`).
    case beginCheckout = "BEGIN_CHECKOUT"
    /// The user submitted shipping information during checkout. `contextInfo.additionalData` carries `amount`, `currency`, `coupon`, `shippingTier` and `items` (see `AdditionalDataKey`).
    case addShippingInfo = "ADD_SHIPPING_INFO"
    /// The user submitted payment information during checkout. `contextInfo.additionalData` carries `amount`, `currency`, `coupon`, `paymentType` and `items` (see `AdditionalDataKey`).
    case addPaymentInfo = "ADD_PAYMENT_INFO"
    /// An order, or part of one, was refunded. `contextInfo.additionalData` carries `transactionId`, `amount`, `currency`, `coupon`, `shipping`, `tax` and `items` (see `AdditionalDataKey`).
    case refund = "REFUND"
    /// The user became a lead, for example by submitting a contact form. `contextInfo.additionalData` carries `amount`, `currency` and `leadSource` (see `AdditionalDataKey`).
    case generateLead = "GENERATE_LEAD"
    /// A lead was marked qualified. `contextInfo.additionalData` carries `amount` and `currency` (see `AdditionalDataKey`).
    case qualifyLead = "QUALIFY_LEAD"
    /// A lead was marked disqualified. `contextInfo.additionalData` carries `amount`, `currency` and `reason` (see `AdditionalDataKey`).
    case disqualifyLead = "DISQUALIFY_LEAD"
    /// A lead was contacted and is being worked. `contextInfo.additionalData` carries `amount`, `currency` and `leadStatus` (see `AdditionalDataKey`).
    case workingLead = "WORKING_LEAD"
    /// A lead converted into a customer. `contextInfo.additionalData` carries `amount` and `currency` (see `AdditionalDataKey`).
    case closeConvertLead = "CLOSE_CONVERT_LEAD"
    /// A lead was closed without converting. `contextInfo.additionalData` carries `amount`, `currency` and `reason` (see `AdditionalDataKey`).
    case closeUnconvertLead = "CLOSE_UNCONVERT_LEAD"
}