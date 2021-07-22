//
//  Video.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import SwiftUI

func videoComparator(first: Dictionary<String, VideoData>.Element, second: Dictionary<String, VideoData>.Element) -> Bool {
    return first.value["name"] as! String > second.value["name"] as! String
}
