//
//  ChatCellView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI


struct ChatCellView: View {
    var body: some View {
        if true {
            HStack {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("あなた")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("hogehogehogehogehoge")
                }
            }
        } else {
            HStack {
                VStack(alignment: .leading) {
                    // FIXME: ChatGPTの返答の時は"GPT 4o"などモデル名が表示されるように
                    Text("GPT 4o")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("hogehogehogehogehoge")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ChatCellView()
}
