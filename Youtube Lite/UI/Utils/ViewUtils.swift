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
                leading: Button(action: { withAnimation { showUser.wrappedValue.toggle() } }, label: {
                    Image(systemName: "person")
                }),
                trailing: Button(action: { showSearch.wrappedValue.toggle() }, label: {
                    Image(systemName: "magnifyingglass")
                }))
    }
}

extension View {
    func largeButton() -> some View {
        return self
            .font(.italic(.title2)())
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(Assets.Colors.colorOnAccent)
            .background(Assets.Colors.accent)
            .cornerRadius(3.0)
    }
}
