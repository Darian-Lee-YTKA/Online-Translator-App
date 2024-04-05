//
//  FireTranslatorApp.swift
//  FireTranslator
//
//  Created by Darian Lee on 4/4/24.
//

import SwiftUI
import FirebaseCore
@main
struct FireTranslatorApp: App {
    @State private var authManager: AuthManager
    @StateObject var email: UserEmail = UserEmail()
    init() {
            FirebaseApp.configure()
        authManager = AuthManager()
        }
    var body: some Scene {
        WindowGroup {
            if authManager.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)
                TranslationView(email:authManager.userEmail!) // <-- Add ChatView
                    .environment(authManager)
                    
                
                
              
            } else {

                // No logged in user, go to LoginView
                LoginView()
                    .environment(authManager)
            }
        }


    }
}
import Combine

class UserEmail: ObservableObject {
    @Published var email: String = ""
}
