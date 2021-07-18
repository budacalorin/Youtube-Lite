//
//  MainViewController.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct MainViewController: View {
    @EnvironmentObject var currentUser: User

    @State var currentTab: Tabs = .home
    
    @State var showUser = false
    @State var showSearch = false
    
    private static let SECCONDS_BEFORE_AUTH_CHECK = 0.5
    
    var body: some View {
        TabView(selection: $currentTab) {
            HomePageView(showUser: $showUser, showSearch: $showSearch)
                .tabItem {
                    getHomeViewTabItem()
                }
                .tag(MainViewController.Tabs.home)
            
            UploadPageView()
                .tabItem {
                    getUploadViewTabItem()
                }
                .tag(MainViewController.Tabs.upload)
            
            PeoplePageView(showUser: $showUser, showSearch: $showSearch)
                .tabItem {
                    getPeopleViewTabItem()
                }
                .tag(MainViewController.Tabs.people)
        }
        .sheet(isPresented: $showUser, content: {
            if (currentUser.isAuthenticated()) {
                UserView()
            } else {
                AuthenticationView()
            }
        })
        .sheet(isPresented: $showSearch, content: {
            SearchView()
        })
        .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + MainViewController.SECCONDS_BEFORE_AUTH_CHECK
        ) { self.showUser = !currentUser.isAuthenticated() }
        
    }
    
    private func getHomeViewTabItem() -> some View {
        return VStack {
            Image(systemName: "house.fill")
        }
    }
    
    private func getUploadViewTabItem() -> some View {
        return VStack {
            Image(systemName: "plus")
        }
        
    }
    
    private func getPeopleViewTabItem() -> some View {
        return VStack {
            Image(systemName: "person.fill")
        }
    }
    
    enum Tabs {
        case home
        case upload
        case people
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewController()
    }
}
