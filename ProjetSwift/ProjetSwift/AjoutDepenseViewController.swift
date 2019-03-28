//
//  AjoutDepenseViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutDepenseViewController : UIViewController {
    
    @IBOutlet weak var titreDepenseTextField: UITextField!
    var newDepense: Depense?
    var voyageSelected: Voyage?
    

    // Declenché lors de l'ajout d'une depense
    // Ajoute une nouvelle depense
    // Parameters : segue 'UIStoryboardSegue'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "depenseAddedSegue" {
            let titreDepense : String  = self.titreDepenseTextField.text!
            let dateDepense : Date = Date()
            let imageDepense  : String  = "Image2"
            self.newDepense  = Depense(titre: titreDepense, photo: imageDepense, date: dateDepense, voyage: self.voyageSelected!)
        }
    }
    
}
