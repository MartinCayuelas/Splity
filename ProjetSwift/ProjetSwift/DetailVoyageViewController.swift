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
         self.imageVoyage.image =  UIImage(named: avoyage.image)
            
        } else {
            self.titreVoyage.text = ""
           
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToDepensesView(segue: UIStoryboardSegue){
        if segue.identifier == "depenseAddedSegue" {
            guard let controller = segue.source as? AjoutDepenseViewController else { return }
            if let depense = controller.newDepense {
                //AJOUTER LA DEPENSE
                //self.depensesTableViewController.depensesModel.add(depense: depense)
            }
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
    
}
