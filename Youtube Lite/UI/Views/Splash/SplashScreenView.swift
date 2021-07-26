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
    
    @StateObject private var viewModel = SplashScreenViewModel()
    
    private static let SECCONDS_BEFORE_SWITCH = 1
    
    var body: some View {
        ZStack {
            Gradient.background
            
            VStack(alignment: .center) {
                Image.logo
                
                iActivityIndicator(style: .rotatingShapes())
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
        .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        DispatchQueue.global().async {
            let timeBefore = DispatchTime.now().uptimeNanoseconds
            
            viewModel.prepareApp()
            
            let diff = DispatchTime.now().uptimeNanoseconds - timeBefore
            
            if diff < (SplashScreenView.SECCONDS_BEFORE_SWITCH * 1000000000) {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(SplashScreenView.SECCONDS_BEFORE_SWITCH)) {
                    stateController.setState(.mainView)
                }
            } else {
                DispatchQueue.main.async {
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
