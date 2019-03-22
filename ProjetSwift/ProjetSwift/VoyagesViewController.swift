//
//  VoyagesViewController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 19/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyagesViewController: UIViewController {

    @IBOutlet weak var labelNomComplet: UILabel!
    @IBOutlet var voyageTableController: VoyagesTableViewController!
    
    let voyageurViewModel: VoyageurSetViewModel = VoyageurSetViewModel()
    
    var voyageurSelected: Voyageur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let voyageur = self.voyageurSelected {
            self.labelNomComplet
                .text = "Voyages de " + voyageur.nomComplet
        } else {
            self.labelNomComplet.text = "Voyages"
        }
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? DetailVoyageViewController {
            if let cell = sender as? UITableViewCell {
                guard let indexPath = self.voyageTableController.tableView.indexPath(for: cell) else {
                    return
                }
                destController.voyageSelected = destController.voyageViewModel.get(voyageAt: indexPath.row)
            }
        }
    }
    
    @IBAction func unwindToMainView(segue: UIStoryboardSegue){
        if segue.identifier == "voyageAddedSegue" {
            guard let controller = segue.source as? AjoutVoyageViewController else { return }
            if let voyage = controller.newVoyage {
                self.voyageTableController.voyages.add(voyage: voyage)
            }
            
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
 

}
