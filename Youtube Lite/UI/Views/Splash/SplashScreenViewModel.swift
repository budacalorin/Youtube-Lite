//
//  SplashScreenViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 26.07.2021.
//

import Foundation

class SplashScreenViewModel: CombineViewModel {
    func prepareApp() {
        if (!User.currentUser.isAuthenticated) {
            User.currentUser.fetchUserData()
        }
    }
}
