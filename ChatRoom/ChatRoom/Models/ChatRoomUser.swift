//
//  ChatRoomUser.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import Foundation

struct ChatroomUser: Identifiable {
    var id: String { uid }
    
    let uid: String
    let name: String
    let email: String?
    let photoUrl: String?
    
    func fetchPhotoUrl() -> URL? {
        guard let photoUrl = photoUrl, let url = URL(string: photoUrl) else {
            return nil
        }
        
        return url
    }
    
}
