//
//  ChatTextFieldView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

struct ChatTextFieldView: View {
    let didSendButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            TextField("メッセージを入力", text: .constant(""))
                .padding()
            
            // MARK: お悩み
            // 1と2どっちが適切なんだろう？
            // -- 1
            // Button {
            //    didSendButtonTapped()
            // } label: {
            //    Image(systemName: "paperplane")
            //         .fontWeight(.bold)
            // }
            // -- 2
            Button(action: didSendButtonTapped) {
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
    ChatTextFieldView {
        print("Sample")
    }
}
