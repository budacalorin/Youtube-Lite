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
    
    var body: some Scene {
        WindowGroup {
            AppViewController()
                .environmentObject(mainStateController)
        }
    }
    
    init() {
//        UserDefaults.standard.removeObject(forKey: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        FirebaseApp.configure()
    }
}
