//
//  OfflineHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation

class OfflineHelper {
    static let defaults = UserDefaults.standard
    
    static func store(data: Data, key: String) {
        OfflineHelper.defaults.set(data, forKey: key)
    }
    
    static func getData(key: String) -> Data? {
        OfflineHelper.defaults.data(forKey: key)
    }
}
