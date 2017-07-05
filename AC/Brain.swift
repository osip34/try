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
    
    var tmp = ""
    var expression: String!
    var result: Double!
    var countOfLeftParentheses: Int = 0
    var countOfRightParentheses: Int = 0
    
    func input(expression: String) {
        while countOfLeftParentheses != countOfRightParentheses {
            tmp = tmp + " )"
            countOfRightParentheses += 1
        }
        
        //self.history = equation
        self.expression = expression + tmp
        //process()

    }
    
    func procces(_ str: String) {
            output.output(value: str)
    }
    
    func equal() {
        tmp = ""
        countOfLeftParentheses = 0
        countOfRightParentheses = 0
        //output.presentHistory(history: "")
        result = CalculateResult()
        if result != nil{
        output.output(value: "\(result!)")
        }
        
    }
    
    func CalculateResult() -> Double {
        let rpnStr = ReverseToPolandNotation(tokens: parseInfix(expression))
        var stack : [String] = []
        
        for tok in rpnStr {
            if Double(tok) != nil {
                stack += [tok]
            } else if tok == "sin" {
                let operand = Double(stack.removeLast())
                stack += [String(sin(operand!))]
            } else {
                let secondOperand = Double(stack.removeLast())
                let firstOperand = Double(stack.removeLast())
                switch tok {
                case "+":
                    stack += [String(firstOperand! + secondOperand!)]
                case "-":
                    stack += [String(firstOperand! - secondOperand!)]
                case "÷":
                    stack += [String(firstOperand! / secondOperand!)]
                case "×":
                    stack += [String(firstOperand! * secondOperand!)]
                case "^":
                    stack += [String(pow(firstOperand!,secondOperand!))]
                default:
                    break
                }
            }
        }
        
        return Double(stack.removeLast())!
    }
    
    func parseInfix(_ equationStr: String) -> [String] {
        let tokens = equationStr.characters.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    func ReverseToPolandNotation(tokens: [String]) -> [String] {
        var rpn : [String] = []
        var stack : [String] = []
        
        for tok in tokens {
            switch tok {
            case "(":
                stack += [tok]
            case ")":
                while !stack.isEmpty {
                    let op = stack.removeLast()
                    if op == "(" {
                        break
                    } else {
                        rpn += [op]
                    }
                }
            default:
                if let operand1 = operation[tok] {
                    for op in stack.reversed() {
                        if let operand2 = operation[op] {
                            if !(operand1.prec > operand2.prec || (operand1.prec == operand2.prec && operand1.rAssoc)) {
                                rpn += [stack.removeLast()]
                                continue
                            }
                        }
                        break
                    }
                    stack += [tok]
                } else {
                    rpn += [tok]
                }
            }
        }
        return (rpn + stack.reversed())
    }
    
    let operation = [
        "^": (prec: 4, rAssoc: true),
        "×": (prec: 3, rAssoc: false),
        "÷": (prec: 3, rAssoc: false),
        "+": (prec: 2, rAssoc: false),
        "-": (prec: 2, rAssoc: false),
        "sin": (prec: 3, rAssoc: true),
        ]

}
