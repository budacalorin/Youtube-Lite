//
//  RateView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 25.07.2021.
//

import SwiftUI

struct RateView: View {
    @Binding var currentRating: Int
    
    let onSelection: (Int) -> Void
    
    var body: some View {
        HStack {
            ForEach(1..<6) { stars in
                if (stars <= currentRating) {
                    Image(systemName: "star.fill")
                        .onTapGesture { ratingSelected(stars) }
                } else {
                    Image(systemName: "star")
                        .onTapGesture { ratingSelected(stars) }
                }
            }
            .foregroundColor(.accent)
        }
    }
    
    private func ratingSelected(_ stars: Int) {
        currentRating = stars
        onSelection(stars)
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(currentRating: .constant(4), onSelection: { _ in })
    }
}
