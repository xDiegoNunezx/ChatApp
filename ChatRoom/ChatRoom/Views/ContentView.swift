//
//  ContentView.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSignIn: Bool
    
    init(showSignIn: Bool = true) {
        self.showSignIn = AuthManager.shared.getCurrentUser() == nil
    }
    
    var body: some View {
        if showSignIn {
            SignInView(showSignIn: $showSignIn)
        } else {
            NavigationStack {
                ZStack {
                    ContactView()
//                    ChatView(chat: Chat.testChat[0])
                }
                .navigationTitle("ChatApp")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            do {
                                try AuthManager.shared.signOut()
                                showSignIn = true
                            } catch {
                                print("Error signing out")
                            }
                        } label: {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
