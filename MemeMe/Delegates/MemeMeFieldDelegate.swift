//
//  MemeMeFieldDelegate.swift
//  MemeMe
//
//  Created by Farzad on 8/11/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class MemeMeFieldDelegate: NSObject,UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text=""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
        return true
    
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
