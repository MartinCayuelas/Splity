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
    
    var depensesTableViewController: DepensesTableViewController!
    @IBOutlet weak var depensesTableView: UITableView!
    var depenseSelected: Depense?
     var voyageSelected: Voyage?
    var depenseImpossible: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.depensesTableViewController = DepensesTableViewController(tableView: depensesTableView, voyageSelected: self.voyageSelected!)
    }
    
    // Pour donner le voyage courant à la page suivante (ajout d'une dépense)
    // Pour affecter à la nouvelle dépense le voyage courant
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? AjoutDepenseViewController {
            destController.voyageSelected = self.voyageSelected
        }
            if let destController = segue.destination as? DetailDepenseViewController {
                if let cell = sender as? UITableViewCell {
                    guard let indexPath = self.depensesTableViewController.depensesTableView.indexPath(for: cell) else {
                        return
                    }
                    destController.depenseCourante = self.depensesTableViewController.depensesModel.get(depenseAt: indexPath.row)
                }
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.depenseImpossible!){
            print("OK")
            //Affichage d'une popup car la dépense n'a pas été créée
            let alert = UIAlertController(title: "La dépense n'a pas pu être créée", message: "Le montant total dépensé doit être même que le montant total à rembourser.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
            
            self.depenseImpossible = false
        }
    }
    

    /// Ajoute la depense à la liste des dépenses et revient à la page de toutes les depenses avec la liste mise à jour
    ///
    /// - Parameter:  segue: 'UIStoryboardSegue'
    /// 
    
    
    @IBAction func unwindToDepensesView(segue: UIStoryboardSegue){
        if segue.identifier == "depenseAddedSegue" {
            guard let controller = segue.source as? AjoutDepenseViewController else { return }
            print(self.depenseImpossible)
            //Si la dépense a des montants non égaux
            
            //Sinon on ajoute la dépense
            if let depense = controller.newDepense {
                self.depensesTableViewController.depensesModel.add(depense: depense)
            }
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
    
}
