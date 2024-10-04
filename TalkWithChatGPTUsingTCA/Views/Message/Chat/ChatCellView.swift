//
//  ChatCellView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

enum MessageAgent {
    case user(_ message: String)
    case assistant(_ response: String)
}

struct ChatCellView: View {
    let agent: MessageAgent
    
    var body: some View {
        // FIXME: リクエスト、レスポンスを適切な名前に変更してください
        switch agent {
        case .user(let request):
            userSendMessage(message: request)
        case .assistant(let response):
            responseFromAgent(message: response)
        }
    }
    
    func userSendMessage(message: String) -> some View {
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("あなた")
                    .font(.title3)
                    .fontWeight(.bold)
                
                // FIXME: レスポンスに応じて変更できるようにしてください
                Text(message)
            }
        }
    }
    
    // FIXME: レスポンスに合ったものにしよう(モデルとレスポンス)
    func responseFromAgent(message: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                // FIXME: ChatGPTの返答の時は"GPT 4o"などモデル名が表示されるように
                Text("GPT 4o")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(message)
            }
            Spacer()
        }
    }
}

#Preview("agent: User") {
    ChatCellView(agent: .user("Hey AI"))
}

#Preview("agent: Assistant") {
    ChatCellView(agent: .assistant("Hey Human"))
}
