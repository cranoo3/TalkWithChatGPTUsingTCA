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
    var fetch: @Sendable (APIRequest) async throws -> APIResponse
    enum FetchError: Error, Equatable {
        case cantGetURLFromPlist
    }
}

extension APIClient: TestDependencyKey {
    static let previewValue = Self(
        fetch: {_ in .mock}
    )
    
    static let testValue = Self()
}

extension APIClient: DependencyKey {
    static let liveValue = APIClient { request in
        let urlString = PlistDecoder.shared.getValue(from: .url) ?? ""
        guard let url = URL(string: urlString) else {
            throw FetchError.cantGetURLFromPlist
        }
        
        let apiKey = PlistDecoder.shared.getValue(from: .apiKey) ?? ""
        let orgId = PlistDecoder.shared.getValue(from: .orgId) ?? ""
        var requestBody = try JSONEncoder().encode(request)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(apiKey)",
            "OpenAI-Organization": "\(orgId)",
            "Content-Type" : "application/json"]
        urlRequest.httpBody = requestBody
        
        // FIXME: レスポンスデータのエラーハンドリングをしよう
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodeData = try jsonDecoder.decode(APIResponse.self, from: data)
        return decodeData
    }
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
