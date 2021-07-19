//
//  UserView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct UserView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Toggle(isOn: $isPresented, label: {
            Text("Label")
        })
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(isPresented: .constant(true))
    }
}
