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
    var startedNum = true
    var buffer: String = "0"
    var resultCollection: [String] = []
    let brain = Brain.shared
    
    
    func input(value: Int) {
        if buffer == "" || buffer == "0" || startedNum {
            buffer = String(value)
            startedNum = false
        } else if buffer.characters.last == "." || buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + "\(value)"
        } else {
            buffer = buffer + " \(value)"
        }
      brain.procces(buffer)
    }
    
    func input(utility: String) {
        
        
        if characterOperationBinary(str: utility) {
            if characterOperationBinary(str: buffer) {
        buffer.characters.removeLast()
                buffer += utility
            } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer += " " + utility
            }
        }
        if utility == "(" {
            if characterOperationBinary(str: buffer) {
            buffer += " " + utility
                brain.countOfLeftParentheses += 1
            } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer += " × ("
                brain.countOfLeftParentheses += 1
            }
        }
            if utility == ")" {
                if !characterOperationBinary(str: buffer) && brain.countOfLeftParentheses > brain.countOfRightParentheses {
                buffer += " " + utility
                }
            }
        startedNum = false
        brain.procces(buffer)
        
        }
    
    
    func enterServiceKey(_ serviceKey: Int) {
        if serviceKey == 100 {
            
            brain.input(expression: buffer)
            brain.equal()
            
            resultCollection.append(buffer + " = \(brain.result!)")
            buffer = "\(brain.result!)"
            startedNum = true
            
            OutputAdapter.shared.reloadPicker()
            
        }
        
        
            //else {
            //buffer = ""
           // brain.clear()
        }
}
func characterOperationBinary (str: String) ->Bool {
    switch str.characters.last! {
    case "+": fallthrough
    case "-": fallthrough
    case "×": fallthrough
    case "÷": return true
    default: return false
        
    }
    }
