//
//  SplashScreenView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import SwiftUI
import iActivityIndicator

struct SplashScreenView: View {
    @EnvironmentObject var stateController: MainStateController
    
    static let SECCONDS_BEFORE_SWITCH = 0.5
    
    var body: some View {
        ZStack {
            Assets.Gradients.background
                .edgesIgnoringSafeArea(.vertical)
            
            VStack(alignment: .center) {
                Assets.Images.logo
                
                iActivityIndicator(style: .rotatingShapes())
                    .frame(width: 100, height: 100, alignment: .center)
            }
                
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + SplashScreenView.SECCONDS_BEFORE_SWITCH
            ) {
                stateController.setState(.mainView)
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
