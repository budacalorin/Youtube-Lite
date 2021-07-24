//
//  UsersHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import FirebaseDatabase

class UsersHelper: DatabaseHelper, ObservableObject {
    
    private(set) var didFirstRead = false
    
    @Published var users: [String: UserData]? = [:]
    
    override init() {
        super.init()
        readUsers()
        startUserListener()
    }
    
    func updateUser(_ user: User) {
        database.child("users").child(user.id!).setValue(user.userData)
    }
    
    func startUserListener() {
        database.child("users").observe(.value) { [weak self] snapshot in
            self?.processUsersSnapshot(snapshot)
        }
    }
    
    func readUsers() {
        database.child("users").getData { [weak self] error, snapshot in
            if let error = error {
                print("Failed to read users. Error: \(error)")
                return
            }
            self?.didFirstRead = true
            self?.processUsersSnapshot(snapshot)
         }
    }
    
    private func processUsersSnapshot(_ snapshot: DataSnapshot) {
        if let value = snapshot.value {
            if !(value is NSNull) {
                users = value as! [String: UserData]?
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
