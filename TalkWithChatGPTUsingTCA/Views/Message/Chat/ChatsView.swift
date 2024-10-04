//
//  ChatsView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

struct ChatsView: View {
    // FIXME: レスポンスデータを渡す必要がありそう？
    
    var body: some View {
        ScrollView {
            ForEach(0...10, id: \.self) { element in
                // FIXME: レスポンスに応じて返答するように変更してください
                ChatCellView(agent: element % 2 != 0 ? .assistant("Hello, human") : .user("Hello, AI"))
                    .padding()
            }
        }
    }
}

#Preview {
    ChatsView()
}
