//
//  User.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import Foundation

class User: ObservableObject {
    @Published var isAuthenticated = false
    
    @Published var emailAddress: String?
    
    @Published var authenticationToken: String?
}
