//
//  VideoData.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation

enum VideoKeys: String {
    case url
    case userUID
    case name
    case description
    case tags
    case stars
}

typealias VideoData = [String : Any]

extension VideoData {
    static let DEFAULT_UNKNOWN = ""
    
    func getUrl() -> String {
        self[VideoKeys.url.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getUserUID() -> String {
        self[VideoKeys.userUID.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getName() -> String {
        self[VideoKeys.name.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getDescription() -> String {
        self[VideoKeys.description.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getTags() -> [String] {
        self[VideoKeys.tags.rawValue] as? [String] ?? []
    }
    mutating func setStars(_ newValue: StarsData) {
        self[VideoKeys.stars.rawValue] = newValue
    }
    func getStars() -> StarsData {
        self[VideoKeys.stars.rawValue] as? StarsData ?? StarsData()
    }
}
