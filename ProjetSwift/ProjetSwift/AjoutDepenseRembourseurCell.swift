//
//  AjoutDepenseRembourseurCell.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 01/04/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutDepenseRembourseurCell: UITableViewCell {

    
    @IBOutlet weak var nomVoyageur: UILabel!
    
    @IBOutlet weak var montantDepense: UITextField!
    
    @IBOutlet weak var checkButton: ButtonCheckBox!
    
}

extension AjoutDepenseRembourseurCell{
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}

extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}
