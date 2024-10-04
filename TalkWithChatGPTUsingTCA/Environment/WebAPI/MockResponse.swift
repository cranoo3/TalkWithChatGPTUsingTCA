//
//  MockResponse.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import Foundation

extension APIResponse {
    static let mock = Self(
        id: "sample",
        object: "sample",
        created: 0,
        model: "GPT-4o",
        choices: [Choice](),
        usage: .init(promptTokens: 0, completionTokens: 0, totalTokens: 0),
        systemFingerprint: nil
    )
}
