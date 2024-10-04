//
//  MessageFeature.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import ComposableArchitecture
import Foundation

@Reducer
struct MessageFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading = false
        var messageParameter = ""
        var isKeyboardFocused = false
        var messages = [Message]()
    }
    
    @Dependency(\.apiClient) var apiClient
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case sendButtonTapped
        case scrollChanged
        case keyboardFocusChanged(Bool)
        case sendRequest(APIRequest)
        case apiResponse(Result<APIResponse, Error>)
    }
    
    // TODO: 🤨ここきったねぇ。解決策はEffect?
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce{
            state,
            action in
            switch action {
            case .binding(\.messageParameter):
                return .none
            case .binding:
                return .none
                
            case .sendButtonTapped:
                // 送信するメッセージを作成
                state.messages.append(Message(role: "user", content: state.messageParameter))
                // TextFieldを空にする、ProgressViewを表示する
                state.messageParameter = ""
                state.isLoading = true
                // FIXME: モデル名 ハードコーディング
                return .send(.sendRequest(APIRequest(model: "gpt-4o", messages: state.messages)))
                
            case .scrollChanged:
                state.isKeyboardFocused = false
                return .none
                
            case let .keyboardFocusChanged(isFocus):
                state.isKeyboardFocused = isFocus
                return .none
                
                // MARK: - リクエスト
            case let .sendRequest(messageData):
                return .run { send in
                    await send(.apiResponse(
                        Result { try await apiClient.fetch(messageData) }
                    ))
                }
                // MARK: - レスポンスデータ
            case let .apiResponse(.success(responseData)):
                guard let message = responseData.choices.first?.message else {
                    // ここって.noneでいいのかな
                    print("message is nil")
                    return .none
                }
                state.messages.append(message)
                state.isLoading = false
                return .none
            case .apiResponse(.failure):
                state.isLoading = false
                return .none
            }
        }
    }
}
