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
    
    let sample = [
        Message(role: "user", content: "Hello"),
        Message(role: "assistant", content: "SwiftUI is a user interface toolkit created by Apple that allows developers to design and build user interfaces across all Apple platforms—iOS, iPadOS, macOS, watchOS, and tvOS—using a declarative Swift syntax. Introduced at WWDC 2019, SwiftUI provides a modern way to create responsive and visually appealing applications with minimal code, thanks to its emphasis on a declarative programming style.\n\n### Key Features of SwiftUI:\n\n1. **Declarative Syntax**: In SwiftUI, you declare what your UI should look like and how it behaves. This makes the code easier to read and maintain. You describe user interfaces using a set of Swift structures that conform to the `View` protocol.\n\n2. **Cross-Platform**: SwiftUI is designed to work seamlessly across all Apple platforms, allowing developers to share code and create interfaces that are native to each device.\n\n3. **Live Previews**: Xcode provides a real-time preview feature, which allows developers to see how their UI looks and behaves in different situations without having to run a simulator or a physical device every time.\n\n4. **Dynamic Type Support**: SwiftUI automatically supports dynamic type, which means fonts can adjust for accessibility, screen size, and other factors.\n\n5. **Data Binding**: SwiftUI uses a reactive programming approach with data binding, allowing the interface to automatically update when data changes. This is accomplished using property wrappers like `@State`, `@Binding`, `@ObservedObject`, `@EnvironmentObject`, and `@FetchRequest`.\n\n6. **Animations and Transitions**: SwiftUI makes it easy to add animations and transitions to make UI interactions more engaging with minimal code.\n\n7. **Integration with UIKit and AppKit**: While SwiftUI is a powerful tool on its own, it can be integrated with UIKit and AppKit to leverage existing infrastructure, particularly when transitioning existing apps to SwiftUI.\n\n8. **Lightweight and Fast**: SwiftUI is designed to be efficient, leveraging Swift's performance capabilities, resulting in smooth and responsive applications.\n\n9. **Environment Objects**: SwiftUI allows sharing data across views using environment objects, which makes it easier to manage state in larger applications.\n\n### Learning SwiftUI:\n\n- **Apple Documentation**: The official documentation and tutorials provided by Apple are an excellent place to start.\n- **Sample Code**: Exploring and modifying Apple's sample code can provide practical insights into building applications with SwiftUI.\n- **Community Resources**: There are numerous blogs, forums, and video tutorials available from the developer community.\n\nOverall, SwiftUI represents a significant shift in how Apple applications are built, emphasizing simplicity, and ease of use, while providing powerful capabilities to create complex and beautiful user interfaces. As it continues to evolve, SwiftUI is becoming an increasingly important tool for Apple developers.")
    ]
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
