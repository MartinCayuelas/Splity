//
//  CreationDepenseTextFieldDelegate.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 03/04/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class CreationDepenseTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("DelegateActive")
        return true
    }
    
    
}
