//
//  CombineViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import Combine

class CombineViewModel: ObservableObject {
    var cancelables = Set<AnyCancellable>()
    
    func initListeners() { }
    
    func cancelListeners() {
        cancelables.forEach { $0.cancel() }
        cancelables.removeAll()
    }
}
