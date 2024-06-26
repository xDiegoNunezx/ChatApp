//
//  Chat.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import Foundation

class Chat: Identifiable {
    var id: String { chatId }
    
    let chatId: String
    let createAt: Date
    let otherUserId: String
    let otherUserName: String
    let otherUserPhotoUrl: String?
    var latestMessage: LatestMessage?
    var unreadCounts: Int
    
//    var chatViewModel: ChatViewModel?
    
    init(chatId: String, createAt: Date, otherUserId: String, otherUserName: String, otherUserPhotoUrl: String, latestMessage: LatestMessage, unreadCounts: Int) {
        self.chatId = chatId
        self.createAt = createAt
        self.otherUserId = otherUserId
        self.otherUserName = otherUserName
        self.otherUserPhotoUrl = otherUserPhotoUrl
        self.latestMessage = latestMessage
        self.unreadCounts = unreadCounts
    }
    
    func fetchPhotoUrl() -> URL? {
        guard let photoUrl = otherUserPhotoUrl, let url = URL(string: photoUrl) else {
            return nil
        }
        
        return url
    }
    
}

struct LatestMessage {
    let lastestMessageTime: Date
    let lastestMessageText: String
    var isRead: Bool
}


extension Chat {
    static let testChat = [
        Chat(chatId: "1",
             createAt: Date(),
             otherUserId: "23456",
             otherUserName: "Kim Bo",
             otherUserPhotoUrl: "https://asianwiki.com/images/3/34/Bo-sung_Kim.jpg",
             latestMessage: LatestMessage(
                lastestMessageTime: Date(),
                lastestMessageText: "This is Kim, please reply to me immediately! Hihihihihihihihihihihihihihihi~~",
                isRead: false
             ),
             unreadCounts: 2
        ),
        Chat(chatId: "2",
             createAt: Date(),
             otherUserId: "34567",
             otherUserName: "John Wick",
             otherUserPhotoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn8_j8xxqBXGCwr1do3aGbOi7kBnRYJjTUYg&usqp=CAU",
             latestMessage: LatestMessage(
                lastestMessageTime: Date(),
                lastestMessageText: "Okayyyy :)",
                isRead: true
             ),
             unreadCounts: 0
        )
    ]
}
