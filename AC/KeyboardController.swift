//
//  KeyboardController.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import UIKit

class KeyboardController: UIViewController {
    
    var onNumTap: ((_ num: Int)->())?
    
    @IBAction func onNumericTap(button: UIButton) {
        onNumTap?(button.tag)
    }
    
    @IBAction func onUtilityTap(button: UIButton) {
        
    }
    
    @IBAction func onBacspaceTap(_ sender: UIButton) {
        
    }
}
