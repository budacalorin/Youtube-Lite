//
//  FirebaseHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import Combine

class FirebaseHelper {
    static let shared = FirebaseHelper()
    
    let authenticator = Authenticator()
    
    let usersHelper = UsersHelper()
    
    let videoHelper = VideoHelper()
    
    private init() { }
    
    func getUserVideosPubllisher(for uid: String) -> AnyPublisher<[Video], Never> {
        videoHelper.$videos
        .map { data -> [Video] in
            data.filter{ $0.value.getUserUID() == uid }.map { Video(fromEncoded: $0) }
        }
        .eraseToAnyPublisher()
    }
    
    func getUserVideos(for uid: String) -> [Video] {
        videoHelper.videos.filter { $0.value.getUserUID() == uid }.map { Video(fromEncoded: $0) }
    }
    
}
