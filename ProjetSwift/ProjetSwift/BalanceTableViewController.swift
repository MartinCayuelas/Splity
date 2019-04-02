//
//  BalanceTableViewController.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 01/04/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class BalanceTableViewController: NSObject, UITableViewDataSource {
    var voyageSelected : Voyage?
    
    var tableView: UITableView!
    var voyageurs : VoyageurSetViewModel
    
    var balanceMax : Double
    
    init(tableView: UITableView, voyageSelected : Voyage){
        self.tableView = tableView
        self.voyageSelected = voyageSelected
        self.voyageurs = VoyageurSetViewModel(voyageurs: VoyageDAO.getAllVoyageurs(forVoyage: self.voyageSelected!))
        self.balanceMax = DepenseDAO.getBalanceMaximale(forVoyage: self.voyageSelected!)
        
        super.init()
        self.tableView.dataSource = self
        
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.voyageurs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardBalanceCell", for: indexPath) as! BalanceCell
        
        
        guard let voyageur = self.voyageurs.get(voyageurAt: indexPath.row) else { return cell }
        //Affichage de la balance pour le voyageur courant et le voyage courant
        
        var balance = VoyageDAO.getBalance(forVoyage: self.voyageSelected!, andVoyageur: voyageur)
        
        
        var taille = self.tailleCell(forTailleMaxCell: self.getTailleMaxCell(), andBalanceMax: self.balanceMax, andBalanceCourante: balance)
        
        //Cas de la balance négative
        if balance < 0.0 {
            
            //Modification des contraintes (largeur)
            for constraint in cell.negatifLabel.constraints {
                if constraint.identifier == "negatifLabelConstraint" {
                    constraint.constant = CGFloat(taille)
                }
            }
            
            for constraint in cell.montantNegatifLabel.constraints {
                if constraint.identifier == "montantNegatifLabelConstraint" {
                    constraint.constant = CGFloat(self.getTailleMaxCell())
                }
            }
            
            for constraint in cell.positifLabel.constraints {
                if constraint.identifier == "positifLabelConstraint" {
                    constraint.constant = CGFloat(self.getTailleMaxCell())
                }
            }
            
            for constraint in cell.montantPositifLabel.constraints {
                if constraint.identifier == "montantPositifLabelConstraint" {
                    constraint.constant = CGFloat(self.getTailleMaxCell())
                }
            }
            
            //Modification du label négatif en rouge
            cell.negatifLabel.backgroundColor = #colorLiteral(red: 0.9479708076, green: 0.04927965999, blue: 0.08589539677, alpha: 0.7451584507)
            cell.negatifLabel.text = ""
            
            //Modification du label négatif avec le montant
            cell.montantNegatifLabel.text = "\(balance) €"
            cell.montantNegatifLabel.backgroundColor = UIColor.clear
            
            //Modification du label positif (sans couleur)
            cell.positifLabel.backgroundColor = UIColor.clear
            cell.positifLabel.text = ""
            
            //Modification du label positif avec le nom du voyageur
            cell.montantPositifLabel.backgroundColor = UIColor.clear
            cell.montantPositifLabel.text = voyageur.nomComplet
        }
            
        //Cas de la balance positive
        else{
            
            //Modification des contraintes (largeurs)
            for constraint in cell.negatifLabel.constraints {
                if constraint.identifier == "negatifLabelConstraint" {
                    constraint.constant = CGFloat(self.getTailleMaxCell())
                }
            }
            
            for constraint in cell.montantNegatifLabel.constraints {
                if constraint.identifier == "montantNegatifLabelConstraint" {
                    constraint.constant = CGFloat(self.getTailleMaxCell())
                }
            }
            
            for constraint in cell.positifLabel.constraints {
                if constraint.identifier == "positifLabelConstraint" {
                    constraint.constant = CGFloat(taille)
                }
            }
            
            for constraint in cell.montantPositifLabel.constraints {
                if constraint.identifier == "montantPositifLabelConstraint" {
                    constraint.constant = CGFloat(self.getTailleMaxCell())
                }
            }
            
           //Modification du label positif en vert
            cell.positifLabel.backgroundColor = #colorLiteral(red: 0.004792788532, green: 0.4702310562, blue: 0.2677494586, alpha: 0.7521181778)
            cell.positifLabel.text = ""
            
            //Modification du label positif avec le montant
            cell.montantPositifLabel.text = "\(balance) €"
            cell.montantPositifLabel.backgroundColor = UIColor.clear
            
            //Modification du label négatif (sans couleur)
            cell.negatifLabel.backgroundColor = UIColor.clear
            cell.negatifLabel.text = ""
            
            //Modification du label négatif avec le nom du voyageur
            cell.montantNegatifLabel.backgroundColor = UIColor.clear
            cell.montantNegatifLabel.text = voyageur.nomComplet
            
        }
        return cell
    }
    
    
    
    //Calcul de la taille maximale que peut prendre une barre horizontale
    private func getTailleMaxCell() -> Int{
        
        var max : Int = 0
        if #available(iOS 12.0, *) {
            max = Int(self.tableView.visibleSize.width / 2)
        }
        return max - 15
    }
        
        //Calcule la taille de la cell courante
        private func tailleCell(forTailleMaxCell tailleMax: Int, andBalanceMax balanceMax: Double, andBalanceCourante balanceCourante: Double) -> Int{
            var taille : Int = 0
            //Produit en croix
            
            var balanceM = Int(balanceMax)
            
            //Eviter la division par 0
            if(balanceM == 0) {
                return 0
            }
            
            var balanceC = Int(balanceCourante)
            if (balanceC < 0){
                balanceC = balanceC * -1
            }
            
            return (tailleMax * balanceC) / balanceM
            
            
        }

    
    
    
}
