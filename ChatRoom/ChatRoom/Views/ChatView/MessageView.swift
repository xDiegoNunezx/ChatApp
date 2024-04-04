//
//  MessageView.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageView: View {
    var message: Message
    
    var body: some View {
        
        if message.isSender() {
            HStack {
                // ====================== Text =========================
                HStack {
                    Text(message.text)
                        .padding()
                        .foregroundColor(Color(uiColor: .lightText))
                        .background(Color(uiColor: .systemBlue))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 260, alignment: .trailing)
                
                
                // ====================== Image =========================
                if let photoUrl = message.fetchPhotoUrl() {
                    WebImage(url: photoUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.trailing, 4)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.trailing, 4)
                        .foregroundColor(.gray)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
        } else {
            HStack {
                // ====================== Image =========================
                if let photoUrl = message.fetchPhotoUrl() {
                    WebImage(url: photoUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.trailing, 4)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.trailing, 4)
                        .foregroundColor(.gray)
                }
                
                // ====================== Text =========================
                HStack {
                    Text(message.text)
                        .padding()
                        .foregroundColor(Color(uiColor: .lightText))
                        .background(Color(uiColor: .systemGray4))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 260, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
        }
    }
}

#Preview {
    MessageView(
        message: Message(
            chatId: "1",
            userId: "12345",
            text: "Test message",
            photoUrl: "",
            createAt: Date())
    )
}
