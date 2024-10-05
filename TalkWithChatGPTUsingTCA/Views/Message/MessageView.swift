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
        GeometryReader { reader in
            ZStack {
                ChatsView(messages: store.messages)
                    .gesture (
                        DragGesture()
                            .onChanged { _ in
                                 store.send(.scrollChanged)
                            }
                    )
                VStack {
                    // 画面上部グラデーション
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
                    
                    // TODO: 🤨storeのバケツリレーはどうにかなりそう？store.scope()の使い方がよく分かりません
                    MessageTextFieldView(store: store)
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
        
        
        //        GeometryReader { reader in
        //            ZStack {
        //                ChatsView(messages: store.messages)
        //                // ChatsView(messages: sample)
        //                    .
        //
        //                VStack {
        //                    // 画面上部グラデーション
        //                    Rectangle()
        //                        .ignoresSafeArea()
        //                        .frame(height: reader.safeAreaInsets.top / 2)
        //                        .foregroundStyle(
        //                            LinearGradient(
        //                                colors: [.gray, .clear],
        //                                startPoint: .top,
        //                                endPoint: .bottom
        //                            )
        //                        )
        //
        //                    Spacer()
        //
        //                    if store.isLoading {
        //                        ProgressView()
        //                    }
        //
        //                    Spacer()
        //
        //                    // TODO: 🤨storeのバケツリレーはどうにかなりそう？store.scope()の使い方がよく分かりません
        //                    MessageTextFieldView(store: store)
        //                        .shadow(radius: 10)
        //                        .padding()
        //                }
        //            }
        //        }
    }
}

#Preview {
    MessageView(
        store: Store(initialState: MessageFeature.State()) {
            MessageFeature()
        }
    )
}
