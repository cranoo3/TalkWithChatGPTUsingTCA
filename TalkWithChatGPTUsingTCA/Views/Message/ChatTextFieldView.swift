//
//  ChatTextFieldView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

struct ChatTextFieldView: View {
    var body: some View {
        HStack {
            TextField("メッセージを入力", text: .constant(""))
                .padding()
            
            Button() {
                
            } label: {
                Image(systemName: "paperplane")
                    .fontWeight(.bold)
            }
            .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
    }
}

#Preview {
    ChatTextFieldView()
}
