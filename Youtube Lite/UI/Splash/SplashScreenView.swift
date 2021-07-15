//
//  SplashScreenView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var stateController: MainStateController
    
    static let SECCONDS_BEFORE_SWITCH = 3.0
    
    var body: some View {
        ZStack {
            Assets.background
                .edgesIgnoringSafeArea(.vertical)
            
            Text("Splash Screen")
                .onAppear {
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + SplashScreenView.SECCONDS_BEFORE_SWITCH
                    ) {
                        stateController.setState(.mainView)
                    }
                }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
