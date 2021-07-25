//
//  VideoList.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import SwiftUI

struct VideoList<Content>: View where Content: View {
    
    let videos: [Video]
    
    let header: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: SeeAllView(videos: videos, title: header)) {
                HStack {
                    header()
                
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 3) {
                    if (!videos.isEmpty) {
                        ForEach(videos, id: \.id) { video in
                            NavigationLink(destination: VideoView(video: video, relatedVideos: videos)) {
                                VStack(alignment: .leading, spacing: 1) {
                                    
                                    ThumbnailView(video: video)
                                        .frame(width: 150, height: 100)
                                    
                                    Text(video.videoData.getName())
                                        .foregroundColor(.secondary)
                                    
                                    HStack {
                                        Circle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.accent)
                                        
                                        Text(FirebaseHelper.shared.usersHelper.getUserName(forUID: video.videoData.getUserUID()) ?? "UNKNOWN")
                                            .font(.subheadline)
                                            .foregroundColor(.colorOnPrimary)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(5)
                                .background(Color.formField.opacity(0.2))
                                .cornerRadius(3.0)
                            }
                        }
                    } else {
                        Text("No videos")
                            .padding(5)
                            .background(Color.formField.opacity(0.2))
                            .cornerRadius(3.0)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(videos: [Video.dummy, Video.dummy, Video.dummy, Video.dummy]) {
            Text("Nothing")
        }
    }
}

