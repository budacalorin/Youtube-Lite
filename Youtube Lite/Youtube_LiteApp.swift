//
//  Youtube_LiteApp.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import SwiftUI
import Firebase

@main
struct Youtube_LiteApp: App {
    @State var mainStateController = MainStateController(initialState: .splashScreen)

    @State var currentUser = User()
    
    var body: some Scene {
        WindowGroup {
            AppViewController()
                .environmentObject(mainStateController)
                .environmentObject(currentUser)
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}
