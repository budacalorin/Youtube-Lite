//
//  VideoList.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import SwiftUI

struct VideoList: View {
    let videos: [Video]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(videos, id: \.id) { video in
                    NavigationLink(destination: VideoView(video: video, relatedVideos: videos)) {
                        VStack(alignment: .leading) {
                            
                            ThumbnailView(video: video)
                                .frame(width: 150, height: 100)
                            
                            Text(video.videoData.getName())
                                .foregroundColor(.colorOnPrimary)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(videos: [Video.dummy, Video.dummy, Video.dummy, Video.dummy])
    }
}

