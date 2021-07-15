//
//  MainController.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import SwiftUI

struct MainViewController: View {
    @EnvironmentObject var stateController: MainStateController
    
    var body: some View {
        switch stateController.state {
            case .splashScreen:
                SplashScreenView()
            case .mainView:
                EmptyView()
        }
    }
    
    
}

struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewController()
    }
}
