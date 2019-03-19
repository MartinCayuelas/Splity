//
//  DetailVoyageController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 18/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DetailVoyageViewController: UIViewController{
    
    @IBOutlet weak var imageVoyage: UIImageView!
    @IBOutlet weak var titreVoyage: UILabel!
    
    let voyageViewModel: VoyageSetViewModel = VoyageSetViewModel()
    
    var voyageSelected : Voyage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let avoyage = self.voyageSelected {
            self.titreVoyage
                .text = avoyage.titre
         //   self.prenomLabel.text = aperson.firstName
            
        } else {
            self.titreVoyage.text = ""
           
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
