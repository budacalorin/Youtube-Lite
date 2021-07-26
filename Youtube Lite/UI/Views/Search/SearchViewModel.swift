//
//  SearchViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation

class SearchViewModel: CombineViewModel {
    @Published var allVideos: [Video] = []
    
    @Published var currentSearch = ""
    
    @Published var searchedVideos: [Video] = []
    
    override func initListeners() {
        FirebaseHelper.shared.videoHelper.$videos
            .sink { [weak self] videos in
                self?.allVideos = videos.map{ Video(fromEncoded: $0) }
            }
            .store(in: &cancellables)
        
        $currentSearch
            .debounce(for: 0.5, scheduler: DispatchQueue.global())
            .sink { [weak self] newSearch in
                DispatchQueue.main.async { [weak self] in
                    if newSearch.isEmpty {
                        self?.searchedVideos = self!.allVideos
                    } else {
                        self?.searchedVideos = self!.allVideos.filter {
                            $0.videoData.getName().localizedCaseInsensitiveContains(newSearch) ||
                                $0.videoData.getDescription().localizedCaseInsensitiveContains(newSearch)
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}
