//
//  FirebaseHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation

class FirebaseHelper {
    static let shared = FirebaseHelper()
    
    let authenticator = Authenticator()
    
    let usersHelper = UsersHelper()
    
    private init() { }
    
}
