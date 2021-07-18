//
//  ViewUtils.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

extension View {
    func setNavigationTitle(title: String, showUser: Binding<Bool>, showSearch: Binding<Bool>) -> some View {
        return self
            .navigationTitle(title)
            .navigationBarItems(
                leading: Button(action: { showUser.wrappedValue = true }, label: {
                    Image(systemName: "person")
                }),
                trailing: Button(action: { showSearch.wrappedValue = true }, label: {
                    Image(systemName: "magnifyingglass")
                }))
    }
}
