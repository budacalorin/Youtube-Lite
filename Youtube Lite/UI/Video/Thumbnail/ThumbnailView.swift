//
//  ThumbnailView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import SwiftUI
import iActivityIndicator

struct ThumbnailView: View {
    
    let video: Video
    
    @StateObject var viewModel = ThumbnailViewModel()
    
    var body: some View {
        if (viewModel.image != nil) {
            viewModel.image
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                
                if (viewModel.error) {
                    Image(systemName: "questionmark")
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(.white)
                } else {
                    iActivityIndicator(style: .rotatingShapes())
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                }
            }
            .onAppear { viewModel.setThumbnail(for: video) }
        }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(video: .dummy)
    }
}
