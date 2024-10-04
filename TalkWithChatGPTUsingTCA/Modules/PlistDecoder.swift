//
//  PlistDecoder.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/05.
//

import Foundation

struct PlistDecoder {
    static let shared = PlistDecoder()
    private var plist: [String: String] = [:]
    private init() {
        guard let url = Bundle.main.url(forResource: "APIInfo", withExtension: "plist") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let tmp = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
            
            guard let plist = tmp as? [String: String] else { return }
            self.plist = plist
        } catch {
            // FIXME: これ、じゃダメじゃないか？
            print("Cant't get Plist Value :(")
        }
    }
    
    enum PlistKeys: String {
        case url
        case model
        case apiKey
        case orgId
    }
    
    func getValue(from key: PlistKeys) -> String? {
        plist[key.rawValue]
    }
}
