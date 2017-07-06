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
    var onUtilityTap: ((_ symbol: String)->())?
    var onServiceTap: ((_ keyNum: Int)->())?
    
    @IBAction func onNumericTap(button: UIButton) {
        onNumTap?(button.tag)
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 0
            button.alpha = 1
        })
    }
    
    @IBAction func onUtilityTap(button: UIButton) {
        onUtilityTap?(button.currentTitle!)
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 0
            button.alpha = 1
        })
    }

    
    @IBAction func onEqualTap(_ sender: UIButton) {
        if IntputAdapter.shared.buffer != "" || !IntputAdapter.shared.startedNum
        {
            IntputAdapter.shared.enterServiceKey(sender.tag)
        }
        UIView.animate(withDuration: 0.5, animations: {
        sender.alpha = 0
        sender.alpha = 1
        })
        
        
    }
    
    @IBAction func onBacspaceTap(_ sender: UIButton) {
        
    }
}
