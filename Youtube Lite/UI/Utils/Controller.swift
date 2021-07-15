//
//  Controller.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 15.07.2021.
//

import Foundation

class Controller<T>: ObservableObject {
    @Published var state: T
    
    func setState(_ newState: T) { state = newState }
    
    init(initialState: T) {
        state = initialState
    }
}

typealias MainStateController = Controller<AppStates>
