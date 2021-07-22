//
//  UsersHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import FirebaseDatabase

class UsersHelper: DatabaseHelper, ObservableObject {
    
    @Published var users: [String: UserData]? = [:]
    
    override init() {
        super.init()
        startUserListener()
    }
    
    func updateUser(_ user: User) {
        database.child("users").child(user.id!).setValue(user.userData)
    }
    
    func startUserListener() {
        database.child("users").observe(.value) { snapshot in
            if let value = snapshot.value {
                if !(value is NSNull) {
                    self.users = value as! [String: UserData]?
                }
            }
        }
    }
    
    func writeUsers() {
        database.child("users").setValue(users)
    }
    
    func getUserName(forUID uid: String) -> String? {
        return users?[uid]?.getName()
    }
    
}
