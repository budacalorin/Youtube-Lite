//
//  VideoView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import SwiftUI

struct VideoView: View {
    
    let video: Video
    
    let relatedVideos: [Video]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Gradient.background
                
                VStack(alignment: .leading) {
                    ZStack {
                        ThumbnailView(video: video)
                            .frame(width: geometry.size.width, height: geometry.size.width / 2)
                    
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Stars: \(video.videoData.getStars())/5")
                            Image(systemName: "star.fill")
                            Spacer()
                        }
                        
                        Text(video.videoData.getName())
                            .font(.title)
                            .italic()
                            .bold()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(video.videoData.getTags(), id: \.self) { tag in
                                    Text("#\(tag)")
                                        .padding(5)
                                        .background(Gradient.uploadButton)
                                        .foregroundColor(.colorOnAccent)
                                        .cornerRadius(10)
                                }
                                
                            }
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Author:")
                                    .foregroundColor(.colorOnPrimary)
                                Text(video.videoData.getUserUID())
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Related videos")
                            VideoList(videos: relatedVideos)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: Video.dummy, relatedVideos: [Video.dummy, Video.dummy])
    }
}
