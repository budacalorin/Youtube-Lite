//
//  HomeVioew.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct HomePageView: View {
    @Binding var showUser: Bool
    @Binding var showSearch: Bool
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Assets.Gradients.background
                
                VStack(alignment: .leading, spacing: 10) {
                    VideoList(videos: viewModel.allVideos)
                
                    VideoList(videos: viewModel.trending)
                
                    VideoList(videos: viewModel.popular)
                }
            }
            .setNavigationTitle(
                title: "Home",
                showUser: $showUser,
                showSearch: $showSearch
            )
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    init(showUser: Binding<Bool>, showSearch: Binding<Bool>) {
        _showUser = showUser
        _showSearch = showSearch
    }
    
    private func onAppear() {
        viewModel.initListeners()
    }
    
    private func onDisappear() {
        viewModel.cancelListeners()
    }
    
    
}

struct HomeVioew_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(showUser: .constant(false), showSearch: .constant(false))
    }
}
