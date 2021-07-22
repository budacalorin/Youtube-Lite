//
//  User.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    static let currentUser = User()
    
    @Published var userData = UserData()
    
    var userUID: String?
    
    @Published var isAuthenticated = false
    
    private init() {
        startListeningForUserChanges()
    }
    
    private func startListeningForUserChanges() {
        FirebaseHelper.shared.authenticator.addStateChangeListener({ (auth, user) in
            guard let user = user else {
                print("Failed to retreive user.")
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                    self.userData = UserData()
                }
                return
            }
            
            self.userData[UserDataKeys.email.rawValue] = user.email
            self.userData[UserDataKeys.name.rawValue] = user.displayName
            self.userUID = user.uid
            
            DispatchQueue.main.async { self.isAuthenticated = true }
        })
    }
    
    func changeName(_ name: String) {
        print("Changing users name")
        
        guard userUID != nil else {
            print("Could not change user name due to userUID being nil")
            return
        }
        
        userData[UserDataKeys.name.rawValue] = name
    }
    
    func commitChanges() {
        guard userUID != nil else {
            print("Could not update user data due to userUID being nil")
            return
        }
        
        FirebaseHelper.shared.usersHelper.updateUser(self)
    }
    
}
