//
//  ThumbnailHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

class ThumbnailHelper {
    static let shared = ThumbnailHelper()
    
    private init() { }
    
    typealias ImageResult = Result<Image, ThumbnailErrors>
    
    let dispatchQueue = DispatchQueue(label: "ThumbnailHelper")
    
    var thumbnails: [String : AnyPublisher<ImageResult, Never>] = [:]
    
    func getThumbnail(forURL url: String) -> AnyPublisher<ImageResult, Never> {
        return dispatchQueue.sync {
            if let image = thumbnails[url] {
                return image
            }
            
            print("Getting image for url \(url)")
        
            let publisher = Just(url)
                .subscribe(on: DispatchQueue.global())
                .map { [weak self] videoURL -> UIImage? in
                    if let image =  ImageHelper.getImage(videoURL: videoURL) {
                        print("Found image stored offline")
                        return image
                    }
                    return self?.getImage(url: videoURL)
                }
                .map { image -> ImageResult in
                    if let image = image {
                        ImageHelper.storeImage(image: image, videoURL: url)
                        return Result<Image, ThumbnailErrors>.success(Image(uiImage: image))
                    } else {
                        return Result<Image, ThumbnailErrors>.failure(ThumbnailErrors.failedToFetch)
                    }
                }
                .eraseToAnyPublisher()
            
            thumbnails[url] = publisher
            
            return publisher
        }
    }
    
    private func getImage(url: String) -> UIImage? {
        guard let url = URL(string: url) else {
            print("Invalid url")
            return nil
        }
        
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(
                at: CMTimeMake(value: 7, timescale: 1),
                actualTime: nil
            )
            return UIImage(cgImage: thumbnailImage)
        } catch {
            print("Error trying to get thumbnail: \(error)")
        }
        
        return nil
    }
}

enum ThumbnailErrors: Error {
    case failedToFetch
}
