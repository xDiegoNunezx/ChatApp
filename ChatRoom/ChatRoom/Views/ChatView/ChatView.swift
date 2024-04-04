//
//  ChatView.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import SwiftUI

struct ChatView: View {
    var chatViewModel: ChatViewModel
    @State var text = ""
    
    init(chatViewModel: ChatViewModel) {
        self.chatViewModel = chatViewModel
    }
    
    var body: some View {
        VStack {
            
            // Message View
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 4) {
                        ForEach(Array(chatViewModel.messages.enumerated()), id: \.element) { idx, message in
                            MessageView(message: message).id(idx)
                        }
                        .onChange(of: chatViewModel.messages) { newValue in
                            scrollView.scrollTo((chatViewModel.messages.count) - 1, anchor: .bottom)
                        }
                    }
                }
            }

            
            // Send Box
            HStack {
                TextField("Send message...", text: $text, axis: .vertical)
                    .padding()
                
                ZStack {
                    Button {
                        if text.count >= 1 {
                            chatViewModel.sendMessage(text: text) { success in
                                if success {
                                    
                                } else {
                                    print("Error sending message!!!")
                                }
                            }
                            text = ""
                        }
                    } label: {
                        Text("Send")
                            .padding()
                            .foregroundColor(Color(uiColor: .white))
                            .background(Color(uiColor: .systemPink))
                            .cornerRadius(50)
                            .padding(.trailing)
                    }
                }
                .padding(.top)
                .shadow(radius: 3)
            }
            .background(Color(uiColor: .systemGray6))
        }
    }
}

#Preview {
    ChatView(chatViewModel: ChatViewModel.mockData)
}
