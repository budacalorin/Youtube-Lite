//
//  VideoView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import SwiftUI
import AVFoundation
import AVKit

struct VideoView: View {
    
    let video: Video
    
    let relatedVideos: [Video]
    
    let player: AVPlayer
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Gradient.background
                
                VStack(alignment: .leading) {
                    ScrollView {
                        
                        ZStack {
                            VideoPlayer(player: player)
                            
//                            Image(systemName: "play.circle.fill")
//                                .resizable()
//                                .frame(width: 50, height: 50)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Stars: \(video.videoData.getStars())/5")
                                Image(systemName: "star.fill")
                                Spacer()
                            }
                            
                            Text(video.videoData.getName())
                                .italic()
                                .bold()
                                .font(.title)
                                .foregroundColor(.colorOnPrimary)
                            
                            Text(video.videoData.getDescription())
                                .foregroundColor(.colorOnPrimary)
                            
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
                                    .foregroundColor(.accent)
                                
                                VStack(alignment: .leading) {
                                    Text("Author:")
                                        .foregroundColor(.colorOnPrimary)
                                    Text(FirebaseHelper.shared.usersHelper.getUserName(forUID: video.videoData.getUserUID()) ?? "UNKNOWN")
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
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(video: Video, relatedVideos: [Video]) {
        self.video = video
        self.relatedVideos = relatedVideos
        player = AVPlayer(url: URL(string: video.videoData.getUrl())!)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: Video.dummy, relatedVideos: [Video.dummy, Video.dummy])
    }
}
