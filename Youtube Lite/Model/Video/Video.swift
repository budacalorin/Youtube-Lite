//
//  View.swift
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
        id: String,
        name: String,
        description: String,
        url: String,
        userUID: String,
        tags: [String],
        stars: StarsData
    ) {
        self.id = id
        
        videoData[VideoKeys.url.rawValue] = url
        videoData[VideoKeys.userUID.rawValue] = userUID
        videoData[VideoKeys.name.rawValue] = name
        videoData[VideoKeys.description.rawValue] = description
        videoData[VideoKeys.tags.rawValue] = tags
        videoData[VideoKeys.stars.rawValue] = stars
    }
    
    convenience init(fromEncoded data: Dictionary<String, VideoData>.Element) {
        self.init(
            id: data.key,
            name: data.value.getName(),
            description: data.value.getDescription(),
            url: data.value.getUrl(),
            userUID: data.value.getUserUID(),
            tags: data.value.getTags(),
            stars: data.value.getStars()
        )
    }
}

extension Video {
    static let dummy = Video(
        id: "q352332145123",
        name: "Sample Video",
        description: "This is a sample video",
        url: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mov-file.mov",
        userUID: "sdgdfgsdfr43rt43wfsd",
        tags: ["Tag1", "Tag2"],
        stars: StarsData()
    )
}
