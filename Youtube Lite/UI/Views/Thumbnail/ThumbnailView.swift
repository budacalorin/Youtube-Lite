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
        if let image = viewModel.image {
            image
                .resizable()
                .scaledToFit()
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(.secondary)
                
                if viewModel.error {
                    Image(systemName: "questionmark")
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(.colorOnSecondary)
                } else {
                    iActivityIndicator(style: .rotatingShapes())
                        .frame(width: 10, height: 10)
                        .foregroundColor(.colorOnSecondary)
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
