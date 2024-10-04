//
//  TalkWithChatGPTUsingTCAApp.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI
import ComposableArchitecture

@main
struct TalkWithChatGPTUsingTCAApp: App {
    static let store = Store(initialState: MessageFeature.State()) {
        MessageFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: TalkWithChatGPTUsingTCAApp.store)
        }
    }
}
