//
//  LoginView.swift
//  FireTranslator
//
//  Created by Darian Lee on 4/5/24.
//

import SwiftUI

struct LoginView: View {
    @State private var currentIndex = 0
    let texts = ["🌍", "🌏", "🌎"]
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(AuthManager.self) var authManager

    var body: some View {
        VStack {
                    Text(self.texts[self.currentIndex])
                .font(.custom("Courier New", size: 150))
                        .animation(.easeInOut(duration: 0.5))
                        .onAppear {
                            let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                withAnimation {
                                    self.currentIndex = (self.currentIndex + 1) % self.texts.count
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .padding()

                    Text("Welcome!")
                        .font(.custom("Courier New", size: 30))
                        .bold()

            // Email + password fields
            VStack {
                TextField("Email", text: $email)
                    .font(.custom("Courier New", size: 18))
                    .bold()
                SecureField("Password", text: $password)
                    .font(.custom("Courier New", size: 18))
                    .bold()
            }
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .padding(40)

            // Sign up + Login buttons
            HStack {
                Button("Sign Up") {
                    print("Sign up user: \(email), \(password)")
                    // TODO: Sign up user
                    authManager.signUp(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                .font(.custom("Courier New", size: 18))
                .bold()

                Button("Login") {
                    print("Login user: \(email), \(password)")
                    // TODO: Login user
                    authManager.signIn(email: email, password: password)
                }
                .buttonStyle(.bordered)
                .font(.custom("Courier New", size: 18))
                .bold()
            }
        }
        .preferredColorScheme(.dark)
    }
}




