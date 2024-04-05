//
//  AuthManager.swift
//  FireTranslator
//
//  Created by Darian Lee on 4/5/24.
//

import Foundation
import FirebaseAuth // <-- Import Firebase Auth

@Observable // <-- Make class observable

class AuthManager {

    
    var user: User?


    let isMocked: Bool
    var userEmail: String?
    
 
    


    
    



    

    init(isMocked: Bool = false) {

       self.isMocked = isMocked


                if isMocked {
                    userEmail = "kingsley@dog.com"
                }
            

       // TODO: Check for cached user for persisted login
    }

    // https://firebase.google.com/docs/auth/ios/start#sign_up_new_users
    func signUp(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                user = authResult.user //
                                userEmail = user?.email
                                print("🌸🌸🌸 User Email:", userEmail)

            } catch {
                print(error)
            }
        }

    }

    // https://firebase.google.com/docs/auth/ios/start#sign_in_existing_users
    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                user = authResult.user
                                userEmail = user?.email
                                print("🌸🌸🌸 User Email:", userEmail)

            } catch {
                print(error)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
                            userEmail = nil
                            print("🌸🌸🌸 User Email:", userEmail)

        } catch {
            print(error)
        }
    }
    
}
import Combine


