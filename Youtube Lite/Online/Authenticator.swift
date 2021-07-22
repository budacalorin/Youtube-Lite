//
//  Authenticator.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import FirebaseAuth

class Authenticator {
    
    func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if let error = error {
                print("Failed to create user. Error: \(error)")
                return
            }
            
            self.changeDisplayName(name) {
                User.currentUser.commitChanges()
            }
        }
    }
    
    func changeDisplayName(_ name: String, callback: (() -> Void)? = nil) {
        print("Changing display name to \(name)")
        
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Failed to change display name. \(error)")
                }
            }
            
            User.currentUser.changeName(name)
            
            callback?()
        }
    }
    
    func signIn(credential: AuthCredential, callback: (() -> Void)? = nil) {
        print("Signing in with \(credential)")
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("Failed to signin. Error: \(error)")
                return
            }
            
            callback?()
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error when signing in: \(error)")
            }
        }
    }
    
    func addStateChangeListener(_ listener: @escaping (Auth, FirebaseAuth.User?) -> Void) {
        Auth.auth().addStateDidChangeListener(listener)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
        } catch {
            print("Failed to sign out. Error \(error)")
        }
    }
}
