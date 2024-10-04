//
//  APIRequest.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import Foundation

struct APIRequest: Encodable {
    let model: String
    let messages: [Message]
}
