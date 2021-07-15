//
//  Youtube_LiteApp.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import SwiftUI

@main
struct Youtube_LiteApp: App {
    @State var mainStateController = MainStateController(initialState: .splashScreen)
    
    var body: some Scene {
        WindowGroup {
            MainViewController()
                .environmentObject(mainStateController)
        }
    }
}
