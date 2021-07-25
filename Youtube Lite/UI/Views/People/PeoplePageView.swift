//
//  PeoplePageView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct PeoplePageView: View {
    @Binding var showUser: Bool
    @Binding var showSearch: Bool
    
    @StateObject var viewModel = PeopleViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Gradient.background
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.userVideos.sorted(by: usersVideosComparator), id: \.key) { userAndVideos in
                            VideoList(videos: userAndVideos.value) {
                                Text(FirebaseHelper.shared.usersHelper.getUserName(forUID: userAndVideos.key) ?? "UNKNOWK")
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .setNavigationTitle(
                title: "People",
                showUser: $showUser,
                showSearch: $showSearch
            )
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    private func onAppear() {
        viewModel.initListeners()
    }
    
    private func onDisappear() {
        viewModel.cancelListeners()
    }
}

struct PeoplePageView_Previews: PreviewProvider {
    static var previews: some View {
        PeoplePageView(showUser: .constant(false), showSearch: .constant(false))
    }
}
