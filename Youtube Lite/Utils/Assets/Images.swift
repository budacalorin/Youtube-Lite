//
//  Images.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 22.07.2021.
//

import Foundation
import SwiftUI

extension Image {
    static var logo: some View {
        return Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250)
    }
}
