//
//  MainController.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import SwiftUI

struct AppViewController: View {
    @EnvironmentObject var stateController: MainStateController
    
    var body: some View {
        switch stateController.state {
            case .splashScreen:
                SplashScreenView()
            case .mainView:
                MainViewController()
        }
    }
}

struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        AppViewController()
    }
}
