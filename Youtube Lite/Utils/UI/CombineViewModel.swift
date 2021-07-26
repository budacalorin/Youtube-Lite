//
//  CombineViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 21.07.2021.
//

import Foundation
import Combine

class CombineViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    func initListeners() { }
    
    func cancelListeners() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
