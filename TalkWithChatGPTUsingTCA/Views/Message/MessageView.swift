//
//  MessageView.swift
//  TalkWithChatGPTUsingTCA
//
//  Created by cranoo on 2024/10/04.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        ZStack {
            ChatsView()
            
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
                    
                    ChatTextFieldView(didSendButtonTapped: {print("Hello")})
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    MessageView()
}
