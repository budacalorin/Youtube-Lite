//
//  ThumbnailViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import SwiftUI
import AVFoundation

class ThumbnailViewModel: CombineViewModel {
    @Published var image: Image?
    
    @Published var error = false
    
    func setThumbnail(for video: Video) {
        DispatchQueue.global().async {
            guard let thumbnail = self.getThumbnail(url: video.videoData.getUrl()) else {
                print("Failed to set thumbnail")
                DispatchQueue.main.async { self.error = true }
                return
            }
            
            DispatchQueue.main.async { self.image = thumbnail }
        }
    }
    
    private func getThumbnail(url: String) -> Image? {
        guard let url = URL(string: url) else {
            print("Invalid url")
            return nil
        }
        
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(
                at: CMTimeMake(value: 1, timescale: 60),
                actualTime: nil
            )
            return Image(uiImage: UIImage(cgImage: thumbnailImage))
        } catch {
            print("Error trying to get thumbnail: \(error)")
        }
        
        return nil
    }
}
