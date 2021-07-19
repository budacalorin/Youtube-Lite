//
//  Assets.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import Foundation
import SwiftUI

class Assets {
    class Gradients {
        static let background = LinearGradient(
            gradient: Gradient(
                colors: [Assets.Colors.backgroundTop, Assets.Colors.backgroundBottom]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let uploadButton = LinearGradient(
            gradient: Gradient(
                colors: [Assets.Colors.uploadGradientTop, Assets.Colors.uploadGradientBottom]
            ),
            startPoint: .top,
            endPoint: .bottom)
    }
    
    class Colors {
        static let backgroundBottom = Color("GradientBottom")
        
        static let backgroundTop = Color("GradientTop")
        
        static let uploadGradientTop = Color("UploadGradientTop")
        
        static let uploadGradientBottom = Color("UploadGradientBottom")
        
        static let accent = Color("Accent")
        
        static let colorOnAccent = Color("ColorOnAccent")
        
        static let colorOnPrimary = Color("ColorOnPrimary")
        
        static let subHeadline = Color("SubHeadline")
        
        static let formField = Color("FormField")
    }
    
    class Images {
        static var logo: some View {
            return Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
        }
    }
}
