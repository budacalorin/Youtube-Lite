//
//  Authenticator.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import FirebaseAuth

class Authenticator {
    
    func signUp(email: String, password: String, name: String, onCompletion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authData, error) in
            if error == nil {
                self?.changeDisplayName(name) {
                    User.currentUser.commitChanges()
                }
            }
            
            onCompletion(authData, error)
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
    
    func signIn(email: String, password: String, onCompletion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: onCompletion)
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
