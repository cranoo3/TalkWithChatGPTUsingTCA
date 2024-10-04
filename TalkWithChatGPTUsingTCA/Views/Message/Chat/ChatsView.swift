//
//  ChatsView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

struct ChatsView: View {
    let messages: [Message]
    
    var body: some View {
        ScrollView {
            ForEach(messages, id: \.hashValue) { element in
                Group {
                    let content = element.content
                    
                    if element.role == "user" {
                        ChatCellView(agent: .user(content))
                    } else {
                        ChatCellView(agent: .assistant(content))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChatsView(messages: [Message]())
}
