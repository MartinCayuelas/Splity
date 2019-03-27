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
    
    var controllerVoyageursTableView: AjoutVoyageurTableViewController!
    
    @IBOutlet weak var tableVoyageurs: UITableView!
    
    @IBOutlet weak var textFieldTitreVoyage: UITextField!
    var newVoyage : Voyage?
    
    var listVoyageurSelectionnes : [Voyageur] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.controllerVoyageursTableView = AjoutVoyageurTableViewController(tableView: tableVoyageurs)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    // Declenché lors de l'ajout d'un voyage
    // Ajoute une nouveau voyage
    // Parameters : segue 'UIStoryboardSegue'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "voyageAddedSegue" {
            let titreVoyage : String  = self.textFieldTitreVoyage.text!
            let imageVoyage  : String  = "beach"
            self.newVoyage  = Voyage(titre: titreVoyage, photo: imageVoyage)
            
            //Pour insérer les instances dans la table 'Participer'
            for v in self.listVoyageurSelectionnes {
                var participation = Participer(dateArrivee: Date(), dateDepart: nil, voyage: self.newVoyage!, voyageur: v)
            }
            
        }
        if segue.identifier == "voyageurAddedSegue" {
            guard let controller = segue.destination as? AjoutVoyageurViewController else { return }
            controller.pagePrecedente = "Voyage"
        }
    }
    
    @IBAction func unwindToAddVoyageView(segue: UIStoryboardSegue){
        if segue.identifier == "voyageurAddedSegue" {
            guard let controller = segue.source as? AjoutVoyageurViewController else { return }
            if let voyageur = controller.newVoyageur {
                self.controllerVoyageursTableView.voyageurs.add(voyageur: voyageur)
                CoreDataManager.save()
              //  self.controllerVoyageursTableView.voyageurs = VoyageurSetViewModel(data: self.controllerVoyageursTableView.fetchResultController.voyageursFetched)
            }
            
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
    
    
    @IBAction func ajoutVoyageurToVoyage(_ sender: ButtonCheckBox) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableVoyageurs)
        if let indexPath = self.tableVoyageurs.indexPathForRow(at: buttonPosition){
            let voyageurCoche = self.controllerVoyageursTableView.voyageurs.get(voyageurAt: indexPath.row)
            
            if self.listVoyageurSelectionnes.contains(voyageurCoche!){ // Si deja dans le tableau
                let index = self.listVoyageurSelectionnes.firstIndex(of: voyageurCoche!)
                
                self.listVoyageurSelectionnes.remove(at: index!)
            }else{// Ajout dans le tableau
                
                self.listVoyageurSelectionnes.append(voyageurCoche!)
            }
        }
        
    }
    
    
    
}
