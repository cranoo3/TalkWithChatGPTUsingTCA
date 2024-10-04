//
//  APIResponse.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import Foundation

struct APIResponse: Decodable, Equatable {
    let id, object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
    let systemFingerprint: String?
    
    init(
        id: String = "",
        object: String = "",
        created: Int = 0,
        model: String = "",
        choices: [Choice] = [Choice](),
        usage: Usage = Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
        systemFingerprint: String? = nil
    ) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.choices = choices
        self.usage = usage
        self.systemFingerprint = systemFingerprint
    }
//    enum CodingKeys: String, CodingKey {
//        case id, object, created, model, choices, usage
//        case systemFingerprint = "system_fingerprint"
//    }
}

// MARK: - Choice
struct Choice: Decodable, Equatable {
    let index: Int
    let message: Message
    let finishReason: String

//    enum CodingKeys: String, CodingKey {
//        case index, message
//        case finishReason = "finish_reason"
//    }
}

// MARK: - Message
// この構造体はリスクエストを送信する際にも使用するので`Codable`
struct Message: Codable, Hashable, Equatable {
    let role, content: String
}

// MARK: - Usage
struct Usage: Decodable, Equatable {
    let promptTokens, completionTokens, totalTokens: Int

//    enum CodingKeys: String, CodingKey {
//        case promptTokens = "prompt_tokens"
//        case completionTokens = "completion_tokens"
//        case totalTokens = "total_tokens"
//    }
}

// MARK: - Encode/decode helpers
final class JSONNull: Decodable, Hashable, Equatable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
