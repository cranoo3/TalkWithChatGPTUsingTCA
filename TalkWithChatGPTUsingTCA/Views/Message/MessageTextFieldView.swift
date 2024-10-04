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
    @FocusState private var isFocused
    
    var body: some View {
        HStack {
            TextField("メッセージを入力", text: $store.messageParameter)
                .onSubmit {
                    store.send(.sendButtonTapped)
                }
                .focused($isFocused)
                // TODO: 🤨この辺はもう少しどうにかなりそう
                .onChange(of: isFocused) { _, newValue in
                    store.send(.keyboardFocusChanged(newValue))
                }
                .onChange(of: store.isKeyboardFocused) { _, newValue in
                    isFocused = newValue
                }
                .padding()
            
            Button{
                store.send(.sendButtonTapped)
            } label: {
                Image(systemName: "paperplane")
                    .fontWeight(.bold)
            }
            .padding()
            .disabled(store.messageParameter.isEmpty)
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
