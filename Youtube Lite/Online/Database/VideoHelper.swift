//
//  VideoHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import FirebaseDatabase

class VideoHelper: DatabaseHelper, ObservableObject {
    
    private(set) var didFirstRead = false
    
    @Published var videos: [String: VideoData] = [:]
    
    override init() {
        super.init()
        readVideos()
        startVideoListener()
    }
    
    func startVideoListener() {
        database.child("videos").observe(.value) { [weak self] snapshot in
            self?.processVideosSnapshot(snapshot)
        }
    }
    
    func readVideos() {
        database.child("videos").getData { [weak self] error, snapshot in
            if let error = error {
                print("Failed to read videos. Error: \(error)")
                return
            }
            self?.didFirstRead = true
            self?.processVideosSnapshot(snapshot)
        }
    }
    
    private func processVideosSnapshot(_ snapshot: DataSnapshot) {
        if let value = snapshot.value {
            if !(value is NSNull) {
                videos = value as! [String: VideoData]
            }
        }
    }

    func updateVideo(video: Video) {
        database.child("videos").child(video.id).setValue(video.videoData)
    }
}
