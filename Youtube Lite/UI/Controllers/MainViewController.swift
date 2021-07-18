//
//  MainViewController.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct MainViewController: View {
    @State var currentTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $currentTab) {
            HomePageView()
                .tabItem {
                    getHomeViewTabItem()
                }
                .tag(MainViewController.Tabs.home)
            
            UploadPageView()
                .tabItem {
                    getUploadViewTabItem()
                }
                .tag(MainViewController.Tabs.upload)
            
            PeoplePageView()
                .tabItem {
                    getPeopleViewTabItem()
                }
                .tag(MainViewController.Tabs.people)
        }
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
