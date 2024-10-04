//
//  ChatTextFieldView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI
import ComposableArchitecture

struct MessageTextFieldView: View {
    @Bindable var store: StoreOf<MessageFeature>
    
    var body: some View {
        HStack {
            TextField("メッセージを入力", text: $store.messageParameter)
                .padding()
            
            Button{
                store.send(.sendButtonTapped)
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
    MessageTextFieldView(
        store: Store(initialState: MessageFeature.State()) {
            MessageFeature()
        }
    )
}
