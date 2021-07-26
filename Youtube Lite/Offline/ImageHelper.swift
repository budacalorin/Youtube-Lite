//
//  ImageHelper.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import Foundation
import SwiftUI

class ImageHelper {
    static func storeImage(image: UIImage, videoURL key: String) {
        OfflineHelper.store(data: image.pngData()!, key: key)
    }
    
    static func getImage(videoURL key: String) -> UIImage? {
        guard let data = OfflineHelper.getData(key: key) else {
            print("Didn't found image stored for \(key)")
            return nil
        }
        
        guard let uiImage = UIImage(data: data) else {
            print("Failed to produce ui image from data")
            return nil
        }
        
        return uiImage
    }
}
