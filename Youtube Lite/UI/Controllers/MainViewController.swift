//
//  MainViewController.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct MainViewController: View {
    
    @State var currentTab: Tabs = .home
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        TabView(selection: $currentTab) {
            HomePageView(showUser: $viewModel.showUser, showSearch: $viewModel.showSearch)
                .tabItem {
                    getHomeViewTabItem()
                }
                .tag(MainViewController.Tabs.home)
            
            UploadPageView()
                .tabItem {
                    getUploadViewTabItem()
                }
                .tag(MainViewController.Tabs.upload)
            
            PeoplePageView(showUser: $viewModel.showUser, showSearch: $viewModel.showSearch)
                .tabItem {
                    getPeopleViewTabItem()
                }
                .tag(MainViewController.Tabs.people)
        }
        .sheet(isPresented: $viewModel.showSearch, content: {
            SearchView()
        })
        .sheet(isPresented: $viewModel.showAuthentication, content: {
            AuthenticationView(isPresented: $viewModel.showAuthentication)
        })
        .onAppear(perform: onAppear)
        .sideMenu(isShowing: $viewModel.showUser) {
            UserView(
                isPresented: $viewModel.showUser,
                showAuthentication: $viewModel.showAuthentication
            )
        }
    }
    
    private func onAppear() {
        viewModel.initListeners()
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
    
    init() {
        
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewController()
    }
}
