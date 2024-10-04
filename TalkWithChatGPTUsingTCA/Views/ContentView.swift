//
//  ContentView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<MessageFeature>
    
    var body: some View {
        VStack {
            MessageView(store: store)
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: MessageFeature.State()) {
            MessageFeature()
        }
    )
}
