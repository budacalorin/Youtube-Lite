//
//  SignupViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 26.07.2021.
//

import Foundation

class SignupViewModel: CombineViewModel {
    @Published var name: String = ""
    
    @Published var email: String = ""
    
    @Published var password: String = ""
    
    @Published var errorMessage = ""
    
    @Published var isProcessing = false
    
    func pressedSignup() {
        DispatchQueue.main.async { [weak self] in self?.isProcessing = true }
        FirebaseHelper.shared.authenticator.signUp(email: email, password: password, name: name) { result, error in
            DispatchQueue.main.async { [weak self] in
                self?.isProcessing = false
                guard error == nil else {
                    self?.errorMessage = error!.localizedDescription
                    return
                }
            }
        }
    }
}
