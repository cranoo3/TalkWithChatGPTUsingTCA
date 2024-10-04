//
//  APIClient.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import Foundation
import ComposableArchitecture

@DependencyClient
struct APIClient {
    var fetch: @Sendable () async throws -> APIResponse    
    struct FetchError: Error, Equatable {}
}

extension APIClient: TestDependencyKey {
    static let previewValue = Self(
        fetch: { .mock}
    )
    
    static let testValue = Self()
}

extension APIClient: DependencyKey {
    static let liveValue = APIClient {
        // FIXME: URLのハードコーディング + 強制アンラップ
        var url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(apiKey)",
            "OpenAI-Organization": organizationID,
            "Content-Type" : "application/json"]
        
        // FIXME: 強制アンラップ
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decodeData = try JSONDecoder().decode(APIResponse.self, from: data)
        
        return decodeData
    }
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
