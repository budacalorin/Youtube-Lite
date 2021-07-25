//
//  UserViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation
import Combine

class UserViewModel: CombineViewModel {
    @Published var userVideos: [Video] = []
    
    private var videoCancelables = Set<AnyCancellable>()
    
    override func initListeners() {
        User.currentUser.$isAuthenticated.sink { [weak self] authenticated in
            guard self != nil else {
                print("Self is nil")
                return
            }
            
            if authenticated {
                FirebaseHelper.shared.videoHelper.$videos
                    .map { $0.filter { video in video.value.getUserUID() == User.currentUser.id }}.sink { [weak self] videos in
                        DispatchQueue.main.async { [weak self] in
                            self?.userVideos = videos.map { Video(fromEncoded: $0) }
                        }
                    }
                    .store(in: &self!.videoCancelables)
            } else {
                self!.cancelVideoListeners()
                DispatchQueue.main.async { [weak self] in
                    self?.userVideos = []
                }
            }
        }.store(in: &cancelables)
    }
    
    private func cancelVideoListeners() {
        videoCancelables.forEach { $0.cancel() }
        videoCancelables.removeAll()
    }
    
    override func cancelListeners() {
        super.cancelListeners()
        cancelVideoListeners()
    }
}
