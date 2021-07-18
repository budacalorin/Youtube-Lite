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
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .setNavigationTitle(
                title: "Home",
                showUser: $showUser,
                showSearch: $showSearch
            )
        }
    }
}

struct HomeVioew_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(showUser: .constant(false), showSearch: .constant(false))
    }
}
