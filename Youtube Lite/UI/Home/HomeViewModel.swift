//
//  HomeViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation

class HomeViewModel: CombineViewModel {
    
    @Published var videos = FirebaseHelper.shared.videoHelper
    
    @Published var allVideos = [Video]()
    
    @Published var trending = [Video]()
    
    @Published var popular = [Video]()
    
    override func initListeners() {
        videos.$videos.map { elements -> [Video] in
            var allVideos = [Video]()
            for element in elements {
                allVideos.append(Video(fromEncoded: element))
            }
            return allVideos
        }.sink { videos in
            DispatchQueue.main.async {
                self.trending = videos
                self.popular = videos
                self.allVideos = videos
            }
        }.store(in: &cancelables)
    }
}
