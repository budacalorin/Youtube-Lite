//
//  SeeAllView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import SwiftUI

struct SeeAllView<Content>: View where Content: View {
    
    let videos: [Video]
    
    let title: () -> Content
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Gradient.background
            
            List {
                ForEach(videos, id: \.id) { video in
                    NavigationLink(destination: VideoView(video: video, relatedVideos: videos)) {
                        HStack {
                            ThumbnailView(video: video)
                                .frame(width: 150, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(video.videoData.getName())
                                
                                Text(FirebaseHelper.shared.usersHelper.getUserName(forUID: video.videoData.getUserUID()) ?? "")
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            HStack {
                title()
                Spacer()
            }
        )
    }
    
    init(videos: [Video], @ViewBuilder title: @escaping () -> Content) {
        self.videos = videos
        self.title = title
        UITableView.appearance().backgroundColor = .none
        UITableViewCell.appearance().backgroundColor = .none
    }
}

struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(videos: [Video.dummy], title: { Text("asdf") })
    }
}
