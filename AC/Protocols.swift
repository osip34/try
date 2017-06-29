//
//  Protocols.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import Foundation

enum Operation {
    case pls
    case min
    case mul
    case div
    case equal
}

protocol InputProtocol {
    func input(value: Int)
    func input(operation: Operation)
}

protocol OutputProtocol {
    func output(value: String)
}

protocol Model {
    func input(operation: Operation)
}
