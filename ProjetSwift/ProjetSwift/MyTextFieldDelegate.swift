//
//  MyTextFieldDelegate.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 11/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class MyTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if titleApp.text != textField.text {
            validateButton.backgroundColor = UIColor(red:1.00, green:0.60, blue:0.20, alpha:1.0)
        }
        return true
    }
    
    
  
    
    @IBOutlet weak var validateButton: UIButton!
    
    @IBOutlet weak var titleApp: UILabel!
}
