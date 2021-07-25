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
        print("Requesting thumbnail")
        DispatchQueue.global().async { [weak self] in
            print("234523452")
            if let strongSelf = self {
                ThumbnailHelper.shared.getThumbnail(forURL: video.videoData.getUrl())
                    .sink { [weak strongSelf] result in
                        print("Sinking")
                        switch result {
                            case .success(let image): strongSelf?.receivedImage(image)
                                
                            case .failure(let error): strongSelf?.receivedFailure(error)
                        }
                    }
                    .store(in: &strongSelf.cancelables)
            }
        }
    }
    
    private func receivedImage(_ image: Image) {
        DispatchQueue.main.async { [weak self] in
            print("setting image \(String(describing: self))")
            self?.image = image
        }
    }
    
    private func receivedFailure(_ error: ThumbnailErrors) {
        DispatchQueue.main.async { [weak self] in
            print("setting error \(String(describing: self))")
            self?.error = true
        }
    }
}
