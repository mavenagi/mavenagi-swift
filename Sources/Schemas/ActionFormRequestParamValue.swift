import Foundation

public enum ActionFormRequestParamValue: Codable, Hashable, Sendable {
    case json(JSONValue)
    case actionFormAttachment(ActionFormAttachment)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(JSONValue.self) {
            self = .json(value)
        } else if let value = try? container.decode(ActionFormAttachment.self) {
            self = .actionFormAttachment(value)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unexpected value."
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.singleValueContainer()
        switch self {
        case .json(let value):
            try container.encode(value)
        case .actionFormAttachment(let value):
            try container.encode(value)
        }
    }
}