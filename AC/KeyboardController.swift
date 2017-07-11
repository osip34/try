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
    var onUtilityTap: ((_ symbol: Int)->())?
    var onServiceTap: ((_ keyNum: Int)->())?
    
    @IBAction func onNumericTap(button: UIButton) {
        onNumTap?(button.tag)
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 0
            button.alpha = 1
        })
    }
    
    @IBAction func onUtilityTap(button: UIButton) {
        onUtilityTap?(button.tag)
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 0
            button.alpha = 1
        })
    }

    
    @IBAction func onBacspaceTap(_ sender: UIButton) {
        
    }
}
