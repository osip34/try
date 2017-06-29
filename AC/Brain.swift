//
//  Brain.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import Foundation

class Brain: Model {
    static let shared = Brain()
    
    let output = OutputAdapter.shared
    
    
    var innerOperation: Operation?
    var operandOne: Double?
    var operandTwo: Double?
    var buffer: String = ""
    
    
    func input(number: Int) {
        buffer += "\(number)"
        process()
    }
    
    func input(operation: Operation) {
        if operandOne == nil {
            operandOne = Double(buffer)
        } else if operandTwo == nil {
            operandTwo = Double(buffer)
        }
        buffer = ""
        
        if operation == .equal {
            var result: Double? = nil
            
            switch innerOperation! {
            case .pls: result = (operandOne ?? 0.0) + (operandTwo ?? 0.0)
            case .min: result = (operandOne ?? 0.0) - (operandTwo ?? 0.0)
            case .mul: result = (operandOne ?? 0.0) * (operandTwo ?? 0.0)
            case .div: result = (operandOne ?? 0.0) / (operandTwo ?? 0.0) 
            default: break
            }
            
            if let result = result {
                output.output(value: "\(result)")
                operandOne = nil
                operandTwo = nil
            }
        } else {
            innerOperation = operation
        }
    }
    
    func process() {
        //....
        output.output(value: buffer)
    }
    func backSpace() {
    buffer = buffer.substring(to: buffer.index(before: buffer.endIndex))
        process()
    }
}
