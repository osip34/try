//
//  DisplayController.swift
//  AC
//
//  Created by AndreOsip on 6/28/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import UIKit

class DisplayController: UIViewController {
    
    
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
}
