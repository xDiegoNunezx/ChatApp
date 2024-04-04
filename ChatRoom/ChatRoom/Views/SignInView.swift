//
//  SignInView.swift
//  ChatRoom
//
//  Created by Diego Ignacio Nunez Hernandez on 30/03/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var showSignIn: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            
            Spacer()
            Image(systemName: "message.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 100)
            
            Text("You haven't signed in yet")
                .font(.largeTitle)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 10) {
                Button {
                    AuthManager.shared.signInWithGoogle { result in
                        switch (result) {
                        case .success(_):
                            showSignIn = false
                        case .failure(let error):
                            print(error)
                        }
                    }
                } label: {
                    Text("Sign in with Google")
                        .padding()
                        .foregroundColor(.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke()
                                .foregroundColor(.primary)
                                .frame(width: 300)
                        )
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}


#Preview {
    SignInView(showSignIn: .constant(true))
}
