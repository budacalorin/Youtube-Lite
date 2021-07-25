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
    
    @State var currentRating: Int
    
    @State var presentVideo = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Gradient.background
                
                VStack(alignment: .leading) {
                    ScrollView {
                        AVPlayerView(player: player)
                            .frame(height: 250)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Stars: \(video.videoData.getStars().getStars().rounded())/5")
                                Image(systemName: "star.fill")
                                Spacer()
                            }
                            
                            HStack {
                                Text("Rate video:")
                                RateView(currentRating: $currentRating, onSelection: {
//                                    video.videoData.getStars().setStart($0, for: User.currentUser.id!)
                                    var stars = video.videoData.getStars()
                                    stars.setStart($0, for: User.currentUser.id!)
                                    video.videoData.setStars(stars)
                                    FirebaseHelper.shared.videoHelper.updateVideo(video: video)
                                })
                                .disabled(!User.currentUser.isAuthenticated)
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
                            
                            VideoList(videos: relatedVideos) {
                                
                                Text("Related videos")
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $presentVideo, onDismiss: player.pause) {
                AVPlayerView(player: player)
                    .edgesIgnoringSafeArea(.all)
            }
            .onDisappear { player.pause() }
        }
    }
    
    init(video: Video, relatedVideos: [Video]) {
        self.currentRating = video.videoData.getStars().getStars(for: User.currentUser.id ?? "") ?? 0
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
