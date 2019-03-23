//
//  DepensesViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DepensesViewController : UIViewController {
    
    @IBOutlet var depensesTableViewController: DepenseTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //affichage des détails
    }

    /// Ajoute la depense à la liste des dépenses et revient à la page de toutes les depenses avec la liste mise à jour
    ///
    /// - Parameter:  segue: 'UIStoryboardSegue'
    /// 
    
    
    @IBAction func unwindToDepensesView(segue: UIStoryboardSegue){
        if segue.identifier == "depenseAddedSegue" {
            guard let controller = segue.source as? AjoutDepenseViewController else { return }
            if let depense = controller.newDepense {
                print(depense.titre)
                self.depensesTableViewController.depensesModel.add(depense: depense)
            }
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
    
}
