//
//  UserData.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation

typealias UserData = [String : String]

enum UserDataKeys: String {
    case email
    case name
}

extension UserData {
    static let DEFAULT_UNKNOWN = ""
    
    func getName() -> String? {
         self[UserDataKeys.name.rawValue] ?? UserData.DEFAULT_UNKNOWN
    }

    func getEmail() -> String? {
        self[UserDataKeys.email.rawValue] ?? UserData.DEFAULT_UNKNOWN
    }
}
