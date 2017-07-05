//
//  ViewController.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var display: DisplayController!
    var keyboard: KeyboardController!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DisplayControllerSegue", let controller = segue.destination as? DisplayController {
            
            display = controller
        } else if segue.identifier == "KeyboardControllerSegue", let controller = segue.destination as? KeyboardController {
            
            keyboard = controller
            keyboard.onNumTap = { [weak self] num in
                self?.onNumericTap(num: num)
            }
            keyboard.onUtilityTap = { [weak self] symbol in
            self?.onUtilityTap(symbol: symbol)
            }

        }
    }
    
    func onNumericTap(num: Int) {
        IntputAdapter.shared.input(value: num)
       
}
    func onUtilityTap(symbol: String) {
        IntputAdapter.shared.input(utility: symbol)
    }



}
