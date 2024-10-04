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
        var responseData: APIResponse = APIResponse()
    }
    
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case sendButtonTapped
        case apiResponse(APIResponse)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce{ state, action in
            switch action {
            case .binding(\.messageParameter):
                return .none
            case .binding:
                return .none
            case .sendButtonTapped:
                return .run { [message = state.messageParameter] send in
                    let urlSession = URLSession.shared
                    // FIXME: 強制アンラップ
                    // FIXME: APIClientみたいなので、通信処理を外に出したいね
                    let (data, _) = try await urlSession.data(from: URL(string: "")!)
                    let decodeData = try? JSONDecoder().decode(APIResponse.self, from: data)
                    await send(.apiResponse(decodeData!))
                }
            case let .apiResponse(responseData):
                state.responseData = responseData
                state.isLoading = false
                return .none
            }
        }
    }
}
