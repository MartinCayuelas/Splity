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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "depenseAddedSegue" {
            let titreDepense : String  = self.titreDepenseTextField.text!
            let montantDepense : Double = 10.5
            let imageDepense  : String  = "Image2"
            self.newDepense  = Depense(titre: titreDepense, montant: montantDepense, image: imageDepense)
            print(self.newDepense?.titre)
        }
    }
    
}
