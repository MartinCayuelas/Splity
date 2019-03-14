//
//  VoyageTableViewCell.swift
//  ProjetSwift
//
//  Created by Nathan Guillaud on 14/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyageTableViewCell: UITableViewCell {
    @IBOutlet weak var titreVoyage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
