//
//  AjoutVoyageurTableViewCell.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 29/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutVoyageurTableViewCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBOutlet weak var nomVoyageur: UILabel!
    @IBOutlet weak var prenomVoyageur: UILabel!
    @IBOutlet weak var boutonAdd: ButtonCheckBox!
    
}
