//
//  NewChatViewModel.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import Foundation

class NewChatViewModel: ObservableObject {
    
    @Published var chatroomUsers = [ChatroomUser]()
    
    init() {
        DatabaseManager.shared.fetchUsers() { [weak self] result in
            switch (result) {
            case .success(let users):
                self?.chatroomUsers = users
            case .failure(let error):
                print(error)
            }
        }
    }
}
