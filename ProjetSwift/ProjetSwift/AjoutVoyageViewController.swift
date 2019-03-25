//
//  AjoutVoyageViewController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 19/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutVoyageViewController: UIViewController {

    @IBOutlet weak var textFieldTitreVoyage: UITextField!
    var newVoyage : Voyage?
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    // Declenché lors de l'ajout d'un voyage
    // Ajoute une nouveau voyage
    // Parameters : segue 'UIStoryboardSegue'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "voyageAddedSegue" {
            let titreVoyage : String  = self.textFieldTitreVoyage.text!
            let imageVoyage  : String  = "Image1"
            self.newVoyage  = Voyage(titre: titreVoyage, photo: imageVoyage)
        }
    }
    

}
