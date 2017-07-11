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
    var result: String!
    var countOfLeftParentheses: Int = 0
    var countOfRightParentheses: Int = 0
    
    func EnterEquation(equation: String) {
        while countOfLeftParentheses != countOfRightParentheses {
            tmp = tmp + " )"
            countOfRightParentheses += 1
        }
        
        self.expression = equation + tmp

    }
    
    func procces(_ str: String) {
        output.presentResult(result: str)
    }
    
    func equal() {
        tmp = ""
        countOfLeftParentheses = 0
        countOfRightParentheses = 0
        result = String(format: "%g", CalculateResult())
        if result != nil{
        output.presentResult(result: result)
        }
        
    }
    
    func CalculateResult() -> Double {
        let rpnStr = ReverseToPolandNotation(tokens: parseInfix(expression))
        var stack : [String] = []
        
        for tok in rpnStr {
            if Double(tok) != nil {
                stack += [tok]
            } else if tok == "sin" || tok == "cos" || tok == "sqrt" || tok == "ln" {
                let operand = Double(stack.removeLast())
                switch tok {
                case "sin": stack += [String(sin(operand!))]
                case "cos": stack += [String(cos(operand!))]
                case "sqrt": stack += [String(sqrt(operand!))]
                case "ln": stack += [String(log(operand!))]
                default: break
                }
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
        "√": (prec: 5, rAssoc: true),
        "×": (prec: 3, rAssoc: false),
        "÷": (prec: 3, rAssoc: false),
        "+": (prec: 2, rAssoc: false),
        "-": (prec: 2, rAssoc: false),
        "sin": (prec: 5, rAssoc: true),
        "cos": (prec: 5, rAssoc: true),
        "ln": (prec: 4, rAssoc: true),
        ]

}
