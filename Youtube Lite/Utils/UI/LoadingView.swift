//
//  LoadingView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import SwiftUI
import iActivityIndicator

struct LoadingView: View {
    
    @Binding var errorMessage: String

    @Binding var isProcessing: Bool

    var body: some View {
        VStack {
            if (!errorMessage.isEmpty) {
                Text(errorMessage)
                    .foregroundColor(.colorOnPrimary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                if (isProcessing) {
                    iActivityIndicator(style: .rotatingShapes(size: 3))
                        .foregroundColor(.accent)
                        .frame(height: 30)
                }
            }
        }
        .padding()
        .frame(minHeight: 30)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(errorMessage: .constant(""), isProcessing: .constant(false))
    }
}
