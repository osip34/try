//
//  DisplayController.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import UIKit

class DisplayController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var historyPicker: UIPickerView!
    @IBOutlet weak var displayLabel: UILabel!
    
    let output = OutputAdapter.shared
    let brain = Brain.shared
    
    func present(value: String) {
        displayLabel.text = value
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.display = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if IntputAdapter.shared.resultCollection.isEmpty {
            return 0
        } else {
            return IntputAdapter.shared.resultCollection.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if IntputAdapter.shared.resultCollection.isEmpty {
            return ""
        } else {
            return IntputAdapter.shared.resultCollection[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let indexOfEqual = IntputAdapter.shared.resultCollection[row].characters.index(of: "=")
        let indexOfResult = IntputAdapter.shared.resultCollection[row].index(indexOfEqual!, offsetBy: 2)
        let subStrResult = IntputAdapter.shared.resultCollection[row].substring(from: indexOfResult)
        
        output.output(value: subStrResult)
        IntputAdapter.shared.buffer = subStrResult
        IntputAdapter.shared.startedNum = true
    
    }
    
}
