//
//  Videpo.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation

enum VideoKeys: String {
    case url = "url"
    case userUID = "userUID"
    case name = "name"
    case description = "description"
    case tags = "tags"
    case stars = "stars"
}

typealias VideoData = [String : Any]

extension VideoData {
    static let DEFAULT_UNKNOWN = ""
    
    func getUrl() -> String {
        return self[VideoKeys.url.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getUserUID() -> String {
        return self[VideoKeys.userUID.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getName() -> String {
        return self[VideoKeys.name.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getDescription() -> String {
        return self[VideoKeys.description.rawValue] as? String ?? VideoData.DEFAULT_UNKNOWN
    }
    func getTags() -> [String] {
        return self[VideoKeys.tags.rawValue] as? [String] ?? []
    }
    func getStars() -> Int {
        return self[VideoKeys.stars.rawValue] as? Int ?? 1
    }
}
