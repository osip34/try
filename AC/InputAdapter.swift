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
    var operationClicked = false
    var buffer: String = "0"
    var resultCollection: [String] = []
    let brain = Brain.shared
    
    
    func enterNum(_ number: Int) {
        if buffer == "" || buffer == "0" || startedNum {
            buffer = String(number)
            startedNum = false
        } else if buffer.characters.last == "." || buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + "\(number)"
        } else {
            buffer = buffer + " \(number)"
        }
      brain.procces(buffer)
    }
    
    func enterUtility(_ symbol: Operation) {
        operationClicked = true
        
        if OperationBinary(_symbol: symbol) {
            if characterOperationBinary(_symbol: buffer) {
        buffer.characters.removeLast()
                switch symbol {
                case .pls: buffer += "+"
                case .min: buffer += "-"
                case .mul: buffer += "×"
                case .div: buffer += "÷"
                default: break
                }
            } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                switch symbol {
                case .pls: buffer += " +"
                case .min: buffer += " -"
                case .mul: buffer += " ×"
                case .div: buffer += " ÷"
                default: break
                }
            }
            startedNum = false
        }
        if symbol == .leftBracket {
            if characterOperationBinary(_symbol: buffer) {
            buffer += " ("
                brain.countOfLeftParentheses += 1
            } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer += " × ("
                brain.countOfLeftParentheses += 1
            }
        }
            if symbol == .rightBracket {
                if !characterOperationBinary(_symbol: buffer) && brain.countOfLeftParentheses > brain.countOfRightParentheses {
                buffer += " )"
                }
            }
        
        if symbol == .equal {
            //startedNum = false
            
            
            brain.EnterEquation(equation: buffer)
            brain.equal()
            
            resultCollection.insert((buffer + " = \(brain.result!)"), at: 0)
            buffer = "\(brain.result!)"
            startedNum = true
            
            OutputAdapter.shared.reloadPicker()
            
            operationClicked = false
        }
        
        if symbol == .clear {
        buffer = "0.0"
            resultCollection = []
            OutputAdapter.shared.reloadPicker()
            brain.procces(buffer)
            startedNum = true
        
        }
        //startedNum = false
        brain.procces(buffer)
        }
    
    
//    func enterServiceKey(_ serviceKey: Int) {
//        if serviceKey == 100 {
//            
//            brain.EnterEquation(equation: buffer)
//            brain.equal()
//            
//            resultCollection.insert((buffer + " = \(brain.result!)"), at: 0)
//            buffer = "\(brain.result!)"
//            startedNum = true
//            
//            OutputAdapter.shared.reloadPicker()
//            
//            operationClicked = false
//            
//        }
//        
//        
//            //else {
//            //buffer = ""
//           // brain.clear()
//        }
    
    func checkBufferEnding() -> Bool{
        if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
        return true
        } else {
            return false
        }
    }
    
    
}
func OperationBinary (_symbol: Operation) ->Bool {
    switch _symbol {
    case .pls: fallthrough
    case .min: fallthrough
    case .mul: fallthrough
    case .div: return true
    default: return false
        
    }
    }

func characterOperationBinary (_symbol: String) ->Bool {
    switch _symbol.characters.last! {
    case "+": fallthrough
    case "-": fallthrough
    case "×": fallthrough
    case "÷": return true
    default: return false
        
    }
}
