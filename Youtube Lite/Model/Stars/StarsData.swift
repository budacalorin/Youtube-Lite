//
//  StarsData.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation

typealias StarsData = [String : Int]

extension StarsData {
    func getStars() -> Double {
        var sum = 0
        forEach { sum += $0.value }
        return sum == 0 ? 0.0 : Double(sum) / Double(count)
    }
    
    func getStars(for userUID: String) -> Int? {
        return self[userUID]
    }
    
    mutating func setStart(_ stars: Int, for userUID: String) {
        if stars <= 5 && stars >= 1 {
            self[userUID] = stars
        }
    }
}
