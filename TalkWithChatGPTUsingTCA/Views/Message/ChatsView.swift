//
//  ChatsView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

struct ChatsView: View {
    var body: some View {
        ScrollView {
            ForEach(0...10, id: \.self) { _ in
                ChatCellView()
                    .padding()
            }
        }
    }
}

#Preview {
    ChatsView()
}
