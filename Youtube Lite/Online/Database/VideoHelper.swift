//
//  VideoHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import FirebaseDatabase
import Combine

class VideoHelper: DatabaseHelper, ObservableObject {
    
    private(set) var didFirstRead = false
    
    @Published var videos: [String: VideoData] = [:]
    
    private static let DB_NAME = "videos"

    private lazy var databasePath: DatabaseReference = database.child(VideoHelper.DB_NAME)
    
    override init() {
        super.init()
        readVideos()
        startVideoListener()
    }
    
    func startVideoListener() {
        databasePath.observe(.value) { [weak self] snapshot in
            self?.processVideosSnapshot(snapshot)
        }
    }
    
    func readVideos() {
        databasePath.getData { [weak self] error, snapshot in
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
        databasePath.child(video.id).setValue(video.videoData)
    }
    
    func getUserVideosPublisher(for uid: String) -> AnyPublisher<[Video], Never> {
        $videos
        .map { data -> [Video] in
            data.filter{ $0.value.getUserUID() == uid }.map { Video(fromEncoded: $0) }
        }
        .eraseToAnyPublisher()
    }
    
    func getUserVideos(for uid: String) -> [Video] {
        videos.filter { $0.value.getUserUID() == uid }.map { Video(fromEncoded: $0) }
    }
}
