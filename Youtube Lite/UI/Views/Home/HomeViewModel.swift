//
//  HomeViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import Combine

class HomeViewModel: CombineViewModel {
    
    @Published var videos = FirebaseHelper.shared.videoHelper
    
    @Published var allVideos = [Video]()
    
    @Published var trending = [Video]()
    
    @Published var popular = [Video]()
    
    override func initListeners() {
        filterAndGetVideos(filter: { _ in true } )
        .sink { videos in
            DispatchQueue.main.async {
                self.allVideos = videos
            }
        }.store(in: &cancellables)
        
        filterAndGetVideos(filter: { $0.getStars().getStars() < 3} )
        .sink { videos in
            DispatchQueue.main.async {
                self.trending = videos
            }
        }.store(in: &cancellables)
        
        filterAndGetVideos(filter: { $0.getStars().getStars() >= 4} )
        .sink { videos in
            DispatchQueue.main.async {
                self.popular = videos
            }
        }.store(in: &cancellables)
    }
    
    private func filterAndGetVideos(filter: @escaping (VideoData) -> Bool) -> AnyPublisher<[Video], Never> {
        videos.$videos.map { elements -> [Video] in
            var returnedList = [Video]()
            
            for element in elements {
                if filter(element.value) {
                    returnedList.append(Video(fromEncoded: element))
                }
            }
            
            return returnedList
        }.eraseToAnyPublisher()
    }
}
