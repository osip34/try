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
    
    var resultDisplay: ((String)->())?
    var reloadPickerDisplay: (()->())?
    
    func presentResult(result: String) {
        resultDisplay?(result)
    }
    func reloadPicker() {
        reloadPickerDisplay?()
    }
    }
