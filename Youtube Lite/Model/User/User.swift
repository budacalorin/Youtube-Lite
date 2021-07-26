//
//  User.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import Foundation
import SwiftUI
import FirebaseAuth

class User: ObservableObject, Identifiable {
    static let currentUser = User()
    
    @Published var userData = UserData()
    
    @Published var isAuthenticated = false
    
    var id: String?
    
    private init() {
        startListeningForUserChanges()
        fetchUserData()
    }
    
    private func startListeningForUserChanges() {
        FirebaseHelper.shared.authenticator.addStateChangeListener({ [weak self] (auth, user) in
            guard let user = user else {
                print("Failed to retrieve user.")
                DispatchQueue.main.async {
                    self?.removeSigninData()
                }
                return
            }
            
            self?.authenticate(with: user)
        })
    }
    
    private func authenticate(with data: FirebaseAuth.User) {
        userData[UserDataKeys.email.rawValue] = data.email
        userData[UserDataKeys.name.rawValue] = data.displayName
        id = data.uid
        
        DispatchQueue.main.async { self.isAuthenticated = true }
    }
    
    func fetchUserData() {
        guard let user = FirebaseHelper.shared.authenticator.getCurrentUser() else {
            print("Could not fetch user data. Not logged in")
            return
        }
        authenticate(with: user)
    }
    
    private func removeSigninData() {
        isAuthenticated = false
        id = nil
        userData = UserData()
    }
    
    func changeName(_ name: String) {
        print("Changing users name")
        
        guard id != nil else {
            print("Could not change user name due to userUID being nil")
            return
        }
        
        userData[UserDataKeys.name.rawValue] = name
    }
    
    func commitChanges() {
        guard id != nil else {
            print("Could not update user data due to userUID being nil")
            return
        }
        
        FirebaseHelper.shared.usersHelper.updateUser(self)
    }
    
}
