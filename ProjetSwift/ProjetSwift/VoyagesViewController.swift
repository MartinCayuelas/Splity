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
    @IBOutlet weak var voyagesTableView: UITableView!
    var controllerVoyagesTableView: VoyagesTableViewController!
    
    
    var voyageurSelected: Voyageur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerVoyagesTableView = VoyagesTableViewController(tableView: voyagesTableView)
        self.controllerVoyagesTableView.voyageur = self.voyageurSelected
        if let voyageur = self.voyageurSelected {
            self.labelNomComplet
                .text = "Voyages de " + voyageur.nomComplet
        } else {
            self.labelNomComplet.text = "Voyages"
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    
    /// Appelé lorsque l'on clique sur une cellule de la liste des voyages
 /// Recupere le voyage de la cellule
 /// - Parameters: segue 'UIStoryboardSegue', sender 'UITableViewCell'
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? DetailVoyageViewController {
            if let cell = sender as? UITableViewCell {
                guard let indexPath = self.controllerVoyagesTableView.tableView.indexPath(for: cell) else {
                 return
                 }
                 destController.voyageSelected = self.controllerVoyagesTableView.voyages.get(voyageAt: indexPath.row)
            }
        }
    }
    
     /// Appelé lorsque l'on ajoute un voyage à la liste des voyages
 /// Ajoute le voyage et revient à la liste des voyages mise à jour
 /// - Parameters: segue 'UIStoryboardSegue'
    
    @IBAction func unwindToVoyagesView(segue: UIStoryboardSegue){
        if segue.identifier == "voyageAddedSegue" {
            guard let controller = segue.source as? AjoutVoyageViewController else { return }
            if let voyage = controller.newVoyage {
                self.controllerVoyagesTableView.voyages.add(voyage: voyage)
            }
            
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
    
    
}
