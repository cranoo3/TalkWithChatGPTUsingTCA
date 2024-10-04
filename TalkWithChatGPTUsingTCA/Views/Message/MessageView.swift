//
//  MessageView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI
import ComposableArchitecture

struct MessageView: View {
    let store: StoreOf<MessageFeature>
    
    var body: some View {
        ZStack {
            ChatsView()
            
            // 画面上部グラデーション
            GeometryReader { reader in
                VStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(height: reader.safeAreaInsets.top / 2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.gray, .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    Spacer()
                    
                    if store.isLoading {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                    MessageTextFieldView(store: store)
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    MessageView(
        store: Store(initialState: MessageFeature.State()) {
            MessageFeature()
        }
    )
}
