//
//  ContactRowView.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContactRowView: View {
    
    let chat: Chat
    let pinned: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            
            // Photo
            if let photoUrl = chat.fetchPhotoUrl() {
                WebImage(url: photoUrl)
                    .resizable()
                    .frame(maxWidth: 70, maxHeight: 70)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(maxWidth: 70, maxHeight: 70)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }
            
            // Text
            ZStack {
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 10) {
                        // Name & Time
                        HStack {
                            Text(chat.otherUserName)
                                .font(
                                    .system(size: 14).weight(.bold)
                                )
                            Spacer()
                            Text(chat.latestMessage?.lastestMessageTime.discriptiveString() ?? chat.createAt.discriptiveString())
                                .font(
                                    .system(size: 14).weight(.medium)
                                )
                        }
                        .padding(.top, 32)
                        
                        // Latest Message
                        HStack {
                            Text(chat.latestMessage?.lastestMessageText ?? "")
                                .font(.system(size: 14).weight(.medium))
                                .foregroundColor(!(chat.latestMessage?.isRead ?? false) ? Color(uiColor: .black) : Color(uiColor: .gray))
                                .lineLimit(1)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 20)
                        }
                    }.layoutPriority(1.0)
                    if pinned {
                        Label("", systemImage: "staroflife.fill")
                            .foregroundColor(Color(uiColor: .systemYellow))
                            .frame(width: 18, height: 18)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .layoutPriority(0.5)
                    }
                }
            }
        }
        .frame(maxHeight: 80)
    }
}

#Preview {
    ContactRowView(chat: Chat.testChat[0], pinned: true)
}
