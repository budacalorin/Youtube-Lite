//
//  MainViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import Combine

class MainViewModel: CombineViewModel {
    @Published var showUser = false
    @Published var showSearch = false
    @Published var showAuthentication = false

    override func initListeners() {
        User.currentUser.$isAuthenticated
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { newValue in
                DispatchQueue.main.async { self.showAuthentication = !newValue }
            }
            .store(in: &cancelables)
    }
}
