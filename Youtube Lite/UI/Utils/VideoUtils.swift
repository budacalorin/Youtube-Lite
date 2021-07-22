//
//  Video.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import SwiftUI
import AVFoundation

struct VideoList: View {
    let videos: [Video]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(videos, id: \.id) { video in
                    VStack(alignment: .leading) {
                        if let thimbnail = getThumbnail(url: video.videoData.getUrl()) {
                            thimbnail
                                .frame(width: 150, height: 100)
                                .cornerRadius(3.0)
                        } else {
                            Rectangle()
                                .frame(width: 150, height: 100)
                                .cornerRadius(3.0)
                        }
                        
                        Text(video.videoData.getName())
                    }
                }
            }
        }
        .padding()
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        let a = "ABCDE"
        let url = "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mov-file.mov"
        let dummy = Video(id: a, name: a, description: a, url: url, userUID: a, tags: [a,a], stars: 1)
        VideoList(videos: [dummy, dummy, dummy, dummy])
    }
}

func getThumbnail(url: String) -> Image? {
    guard let url = URL(string: url) else {
        print("Invalid url")
            return nil
    }
    
    let asset: AVAsset = AVAsset(url: url)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    
    do {
        let thumbnailImage = try imageGenerator.copyCGImage(
            at: CMTimeMake(value: 1, timescale: 60),
            actualTime: nil
        )
        return Image(uiImage: UIImage(cgImage: thumbnailImage))
    } catch {
        print("Error trying to get thumbnail: \(error)")
    }
    
    return nil
}

func videoComparator(first: Dictionary<String, VideoData>.Element, second: Dictionary<String, VideoData>.Element) -> Bool {
    return first.value["name"] as! String > second.value["name"] as! String
}
