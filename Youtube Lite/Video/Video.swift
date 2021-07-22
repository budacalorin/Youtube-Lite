//
//  ViewData.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation

class Video: ObservableObject, Identifiable, Equatable {
    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    
    @Published var videoData = VideoData()
    
    init(
        name: String,
        description: String,
        url: String,
        userUID: String,
        tags: [String],
        stars: Int
    ) {
        id = UUID().uuidString
        
        videoData[VideoKeys.url.rawValue] = url
        videoData[VideoKeys.userUID.rawValue] = userUID
        videoData[VideoKeys.name.rawValue] = name
        videoData[VideoKeys.description.rawValue] = description
        videoData[VideoKeys.tags.rawValue] = tags
        videoData[VideoKeys.stars.rawValue] = stars
    }
}
