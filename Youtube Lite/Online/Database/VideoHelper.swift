//
//  VideoHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation

class VideoHelper: DatabaseHelper, ObservableObject {
    
    @Published var videos: [String: VideoData] = [:]
    
    override init() {
        super.init()
        startVideoListener()
    }
    
    func startVideoListener() {
        database.child("videos").observe(.value) { snapshot in
            if let value = snapshot.value {
                if !(value is NSNull) {
                    self.videos = value as! [String: VideoData]
                }
            }
        }
    }

    func updateVideo(video: Video) {
        database.child("videos").child(video.id).setValue(video.videoData)
    }
}
