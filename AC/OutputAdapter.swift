//
//  OutputAdapter.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import Foundation

class OutputAdapter: OutputProtocol {
    static let shared = OutputAdapter()
    
    //var display: DisplayController?
    var resultDisplay: ((String)->())?
    var reloadPickerDisplay: (()->())?
    
    func output(value: String) {
        resultDisplay?(value)
        //display?.present(value: value)
    }
    func reloadPicker() {
        //display?.historyPicker.reloadAllComponents()
        reloadPickerDisplay?()
    }
    }
