//
//  FirebaseHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import Combine

class FirebaseHelper {
    static let shared = FirebaseHelper()
    
    let authenticator = Authenticator()
    
    let usersHelper = UsersHelper()
    
    let videoHelper = VideoHelper()
    
    private init() { }
}
