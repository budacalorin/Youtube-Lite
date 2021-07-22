//
//  Gradients.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import SwiftUI

extension Gradient {
    static var background: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.backgroundTop, .backgroundBottom]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.vertical)
    }
    
    static let uploadButton = LinearGradient(
        gradient: Gradient(
            colors: [.uploadGradientTop, .uploadGradientBottom]
        ),
        startPoint: .top,
        endPoint: .bottom)
}
