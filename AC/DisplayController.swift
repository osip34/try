//
//  DisplayController.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import UIKit
import Foundation

class DisplayController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var historyPicker: UIPickerView!
    @IBOutlet weak var displayLabel: UILabel!
    
    let output = OutputAdapter.shared
    let brain = Brain.shared
    let input = IntputAdapter.shared
    
    
    func presentResult(_ result: String) {
        //displayLabel.shadowColor = UIColor.white
        displayLabel.text = result
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.resultDisplay = {[weak self] result in self?.presentResult(result)}
        output.reloadPickerDisplay = {[weak self] in self?.reloadPicker()}
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if input.resultCollection.isEmpty {
            return 0
        } else {
            return input.resultCollection.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if input.resultCollection.isEmpty {
            return NSAttributedString()
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 1
            shadow.shadowColor = UIColor.red
            shadow.shadowOffset = CGSize(width: 2, height: 1)
            let atStr = NSAttributedString(string: input.resultCollection[row], attributes: [NSForegroundColorAttributeName: color, NSShadowAttributeName: shadow, NSUnderlineStyleAttributeName: 1, ])
            
            return atStr
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        input.pickerIsScroling = true
        
        let indexOfEqual = input.resultCollection[row].characters.index(of: "=")
        let indexOfResult = input.resultCollection[row].index(indexOfEqual!, offsetBy: 2)
        let subStrResult = input.resultCollection[row].substring(from: indexOfResult)
        
        if input.operationClicked {
            
            if input.checkBufferEnding()
            {
                input.BufferRemoveSubRange()
            
            }
        input.buffer += " \(subStrResult)"
            
        } else {
        input.buffer = subStrResult
            input.startedNum = true
        }
        output.presentResult(result: input.buffer)
        
    
    }
    
    func reloadPicker() {
    historyPicker.reloadAllComponents()
    historyPicker.selectRow(0, inComponent: 0, animated: true)
    }
    
}
