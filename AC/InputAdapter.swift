//
//  InputAdapter.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import Foundation

class IntputAdapter: InputProtocol {
    static let shared = IntputAdapter()
    
    let brain = Brain.shared
    var operation1: Operation?
    
    func input(value: Int) {
        switch value {
        case 30: brain.input(operation: .min)
        case 60: brain.input(operation: .pls)
        case 100: brain.input(operation: .equal)
            
        default: brain.input(number: value)
        }

    }
    
    func input(operation: Operation) {
        brain.input(operation: operation)
    }
}
