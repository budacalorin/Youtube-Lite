//
//  UserUtils.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation

func usersVideosComparator(first: Dictionary<String, [Video]>.Element, second: Dictionary<String, [Video]>.Element) -> Bool {
    return first.value.count > second.value.count
}
