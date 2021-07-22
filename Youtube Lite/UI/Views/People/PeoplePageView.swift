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
    
    var body: some View {
        NavigationView {
            ZStack {
                Gradient.background
                 
            }
            .setNavigationTitle(
                title: "People",
                showUser: $showUser,
                showSearch: $showSearch
            )
        }
    }
}

struct PeoplePageView_Previews: PreviewProvider {
    static var previews: some View {
        PeoplePageView(showUser: .constant(false), showSearch: .constant(false))
    }
}
