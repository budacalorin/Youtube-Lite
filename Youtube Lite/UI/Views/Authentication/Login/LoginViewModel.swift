//
//  LoginViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 26.07.2021.
//

import Foundation

class LoginViewModel: CombineViewModel {
    @Published var email: String = ""
    
    @Published var password: String = ""
    
    @Published var errorMessage = ""
    
    @Published var isProcessing = false
    
    func pressedLogin() {
        DispatchQueue.main.async { [weak self] in
            self?.isProcessing = true
        }
        FirebaseHelper.shared.authenticator.signIn(email: email, password: password) { result, error in
            DispatchQueue.main.async { [weak self] in
                self?.isProcessing = false
                guard error == nil else {
                    self?.errorMessage = error?.localizedDescription ?? ""
                    return
                }
            }
        }
    }
}
