import Foundation

/// A shared vocabulary of `contextInfo.additionalData` keys, for any event from any sender. Events
/// that carry the same kind of information under the same key share a shape, so one event
/// condition or report works across all of them. Using these keys is encouraged, not required:
/// any other key is still accepted.
/// 
/// Values are strings, like every value in `additionalData`: numbers and booleans as their text
/// (`3`, `true`), anything structured as JSON.
public enum AdditionalDataKey: String, Codable, Hashable, CaseIterable, Sendable {
    /// The new value of whatever changed, never a sum of money (that is `amount`). Absent when undetermined. Maven sets it on `INTELLIGENT_FIELD_VALUE_CHANGED`.
    case value
    /// The value before the change. Absent when it was undetermined or there was none. Maven sets it on `INTELLIGENT_FIELD_VALUE_CHANGED`.
    case previousValue
    /// The name of the thing acted on, such as a form, flow, file, plan or item bought.
    case name
    /// The step reached within a flow or form, as its name or number.
    case step
    /// Why it happened, such as why a handoff was requested or a subscription cancelled.
    case reason
    /// A machine-readable code for the error, for events that report a failure.
    case errorCode
    /// A human-readable description of the error, for events that report a failure.
    case errorMessage
    /// The URL involved, such as the target of a clicked link.
    case url
    /// The text searched for.
    case query
    /// The 1-based position of the chosen item in a list, such as a search result or a suggestion.
    case position
    /// The `botMessageType` of the bot message. Maven sets it on `BOT_REPLY_CREATED`.
    case botMessageType
    /// A monetary amount, as a decimal number in `currency`. A Google Analytics 4 `value` goes here.
    case amount
    /// The ISO 4217 code of `amount`'s currency, such as `USD`.
    case currency
    /// The channel a message went out on, such as `email`, `sms` or `push`.
    case channel
    /// The language content was translated from, as a BCP 47 tag.
    case sourceLanguage
    /// The language content was translated into, as a BCP 47 tag.
    case targetLanguage
    /// The MIME type of the file involved.
    case mimeType
    /// The size of the file involved, in bytes.
    case sizeBytes
    /// How it was done, such as the sign-in method (`google`) or the way content was shared (`copy link`).
    case method
    /// The products involved, as a JSON array in a string. Each object uses the Google Analytics 4 item parameter names (`item_id`, `item_name`, `price`, `quantity`, …), so a GA4 `items` array can be sent as is.
    case items
    /// The ID of the order or transaction.
    case transactionId
    /// The coupon code applied.
    case coupon
    /// The shipping cost, as a decimal number in `currency`.
    case shipping
    /// The tax, as a decimal number in `currency`.
    case tax
    /// Whether the customer is `new` or `returning`.
    case customerType
    /// The payment method chosen, such as `credit card`.
    case paymentType
    /// The shipping option chosen, such as `ground` or `next day`.
    case shippingTier
    /// The ID of the list the products were shown in.
    case itemListId
    /// The name of the list the products were shown in, such as `related products`.
    case itemListName
    /// The ID of the promotion.
    case promotionId
    /// The name of the promotion.
    case promotionName
    /// The name of the promotion's creative, such as a banner.
    case creativeName
    /// Where the promotion's creative was shown.
    case creativeSlot
    /// Where the lead came from, such as `trade show`.
    case leadSource
    /// The lead's status in the sales process, such as `contacted`.
    case leadStatus
    /// The type of the content involved, such as `video` or `article`.
    case contentType
    /// The ID of the content involved.
    case contentId
    /// The ID of the group, team or community involved.
    case groupId
    /// The name of an in-app currency, such as `gems`.
    case virtualCurrencyName
    /// A number of `virtualCurrencyName` units, as a decimal number.
    case virtualCurrencyAmount
    /// The platform that served the ad, such as `AdMob`.
    case adPlatform
    /// The ad network the ad came from, such as `AdColony`.
    case adSource
    /// The ad's format, such as `banner` or `interstitial`.
    case adFormat
    /// The name of the ad unit.
    case adUnitName
}