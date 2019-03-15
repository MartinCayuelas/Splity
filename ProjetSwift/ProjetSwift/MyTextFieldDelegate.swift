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
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    
        if !text.isEmpty{
            validateButton?.isUserInteractionEnabled = true
            validateButton.backgroundColor = UIColor(red:1.00, green:0.64, blue:0.00, alpha:1.0)
           
        } else {
            validateButton?.isUserInteractionEnabled = false
            validateButton.backgroundColor = UIColor(red:1.00, green:0.86, blue:0.60, alpha:1.0)
            
        }
        return true
    }
    
    
    @IBOutlet weak var validateButton: UIButton!
    
}
