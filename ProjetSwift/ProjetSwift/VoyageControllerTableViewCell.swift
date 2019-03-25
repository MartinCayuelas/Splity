//
//  VoyageControllerTableViewCell.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 25/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyageControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageVoyage: UIImageView!
    
    @IBOutlet weak var titreVoyage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
  

}
