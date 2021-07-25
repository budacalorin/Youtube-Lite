//
//  PeopleViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 24.07.2021.
//

import Foundation
import Combine

class PeopleViewModel: CombineViewModel {
    @Published var userVideos: [String : [Video]] = [:]
    
    override init() {
        super.init()
        
        
    }
    
    override func initListeners() {
        FirebaseHelper.shared.usersHelper.$users
            .sink { [weak self] users in
                guard users != nil else {
                    print("No users")
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    users?.keys.forEach { userId in
                        self?.userVideos[userId] = FirebaseHelper.shared.getUserVideos(for: userId)
                    }
                }
            }.store(in: &cancelables)
        
        FirebaseHelper.shared.videoHelper.$videos
            .sink { [weak self] videos in
                DispatchQueue.main.async { [weak self] in
                    videos.map { $0.value.getUserUID() }.forEach { userId in
                        self?.userVideos[userId] = FirebaseHelper.shared.getUserVideos(for: userId)
                    }
                }
            }.store(in: &cancelables)
    }
}
