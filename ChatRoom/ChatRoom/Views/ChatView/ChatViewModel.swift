//
//  ChatViewModel.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import Combine
import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    @Published var chat: Chat
    
    init(chat: Chat, messages: [Message]) {
        self.chat = chat
        self.messages = messages
    }
    
    func sendMessage(text: String, completion: @escaping (Bool) -> Void) {
        guard let user = AuthManager.shared.getCurrentUser() else {
            return
        }
        let msg = Message(chatId: self.chat.chatId, userId: user.uid, text: text, photoUrl: user.photoUrl, createAt: Date())
        
        // Update chat
        DatabaseManager.shared.sendChatToDatabase(chat: chat) { [weak self] success in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        DatabaseManager.shared.sendChatToOtherUserDatabase(chat: chat) { [weak self] success in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        DatabaseManager.shared.sendMessageToDatabase(message: msg) { [weak self] success in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        updateLatestMessage(message: msg)
    }
    
    func updateLatestMessage(message: Message) {
        chat.latestMessage = LatestMessage(
            lastestMessageTime: message.createAt,
            lastestMessageText: message.text,
            isRead: true
        )
    }
    
    func markChatAsRead(newValue: Bool) {
        chat.latestMessage?.isRead = newValue
        DatabaseManager.shared.sendChatToDatabase(chat: chat) { [weak self] success in
            if success {
                
            } else {
                print("markChatAsRead fail")
            }
        }
    }
    
    func refresh() {
        self.messages = messages
    }
}


extension ChatViewModel {
    static let mockData = ChatViewModel(
        chat: Chat(chatId: "1",
                   createAt: Date(),
                   otherUserId: "23456",
                   otherUserName: "Kim Bo",
                   otherUserPhotoUrl: "https://asianwiki.com/images/3/34/Bo-sung_Kim.jpg",
                   latestMessage: LatestMessage(
                    lastestMessageTime: Date(),
                    lastestMessageText: "This is Kim, please reply to me immediately! Hihihihihihihihihihihihihihihi~~",
                    isRead: false
                   ),
                   unreadCounts: 7
                  ),
        messages: [
            Message(chatId: "1", userId: "12345", text: "Test message!!!", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "Test 1111111", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "test test test ttt testttttt!", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "....", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "tEst?", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "ttt_test.", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "Test message!!!", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "Test 1111111", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "test test test ttt testttttt!", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "....", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "tEst?", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "ttt_test.", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "Test message!!!", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "Test 1111111", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "test test test ttt testttttt!", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "....", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "tEst?", photoUrl: "", createAt: Date()),
            Message(chatId: "1", userId: "12345", text: "ttt_test.", photoUrl: "", createAt: Date()),
        ])
}
