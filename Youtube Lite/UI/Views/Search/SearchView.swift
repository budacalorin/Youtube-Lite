//
//  SearchView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct SearchView: View {
    @Binding var isPresented: Bool
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Gradient.background
                
                VStack {
                    HStack(alignment: .lastTextBaseline) {
                        TextField("Type your search here", text: $viewModel.currentSearch)
                        Spacer()
                    }
                    
                    List {
                        ForEach(viewModel.searchedVideos, id: \.id) { video in
                            NavigationLink(destination: VideoView(video: video, relatedVideos: viewModel.searchedVideos)) {
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
                .padding()
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button(
                    action: { isPresented = false }, label: {
                        Text("Cancel")
                    }
                )
            )
            
        }
        .onAppear(perform: viewModel.initListeners)
        .onDisappear(perform: viewModel.cancelListeners)
    }
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        UITableView.appearance().backgroundColor = .none
        UITableViewCell.appearance().backgroundColor = .none
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isPresented: .constant(true))
    }
}
