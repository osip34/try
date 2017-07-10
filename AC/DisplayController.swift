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
    
    func present(value: String) {
        displayLabel.text = value
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //output.display = self
        output.resultDisplay = {[weak self] result in self?.present(value: result)}
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
        
        let indexOfEqual = input.resultCollection[row].characters.index(of: "=")
        let indexOfResult = input.resultCollection[row].index(indexOfEqual!, offsetBy: 2)
        let subStrResult = input.resultCollection[row].substring(from: indexOfResult)
        
        if input.operationClicked {
            //іф ласт чарактер 0юю9  ремов нумбер з спейс
            //let ch = "\(input.buffer.characters.last)"
            //if ["0","1","2","3","4","5","6","7","8","9"].contains(ch)
            
            if input.checkBufferEnding()
            {
                let lastSpaceIndex = input.buffer.range(of: " ", options: String.CompareOptions.backwards, range: nil, locale: nil)?.lowerBound
                
                let ending = input.buffer.endIndex
                let beforEnd = input.buffer.index(before: ending)
                let afterSp = input.buffer.index(after: lastSpaceIndex!)
                if input.buffer != "" {
                    input.buffer.removeSubrange(afterSp...beforEnd)}
            
            }
        input.buffer += " \(subStrResult)"
            
        } else {
        input.buffer = subStrResult
            input.startedNum = true
        }
        output.output(value: IntputAdapter.shared.buffer)
        
    
    }
    
    func reloadPicker() {
    historyPicker.reloadAllComponents()
    }
    
}
