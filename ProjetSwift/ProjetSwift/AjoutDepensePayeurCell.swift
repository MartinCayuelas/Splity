//
//  AjoutDepensePayeurCell.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 29/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutDepensePayeurCell: UITableViewCell {
    
    
    @IBOutlet weak var nomVoyageur: UILabel!
    
    @IBOutlet weak var montantDepense: UITextField!
    
    @IBOutlet weak var checkButton: ButtonCheckBox!
    
}

extension AjoutDepensePayeurCell{
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}

