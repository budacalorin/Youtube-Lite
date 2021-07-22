//
//  UsersHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import FirebaseDatabase

class UsersHelper {
    
    var users: [String: UserData]? = [:]
    
    let database = Database.database().reference()
    
    init() {
        startUserListener()
    }
    
    func updateUser(_ user: User) {
        database.child("users").child(user.userUID!).setValue(user.userData)
    }
    
    func startUserListener() {
        database.child("users").observe(.value) { snapshot in
            if let value = snapshot.value {
                if !(value is NSNull) {
                    self.users = value as! [String: UserData]?
                }
            }
        }
        
//        database.child("users").getData(completion: { (error, snapshot) in
//            if let error = error {
//                print("Error occured while reading users. Error: \(error)")
//                return
//            }
//
//            if (snapshot.exists()) {
//                self.users = snapshot.value! as! [String: UserData]
//            }
//        })
    }
    
    func writeUsers() {
        database.child("users").setValue(users)
    }
    
}
