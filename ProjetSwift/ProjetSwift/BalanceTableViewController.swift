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
        
        
        var taille = self.tailleCell(forTailleMaxCell: self.tailleMaxCell(), andBalanceMax: self.balanceMax, andBalanceCourante: balance)
        print(taille)
        //Cas de la balance négative
        if balance < 0.0 {
            //Modification du label négatif
            cell.montantNegatifLabel.text = "\(balance) €"
            //Multiplicateur
            
             cell.negatifLabel.addConstraint(NSLayoutConstraint(item: cell.negatifLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(taille)))
            
            cell.negatifLabel.backgroundColor = #colorLiteral(red: 0.9479708076, green: 0.04927965999, blue: 0.08589539677, alpha: 0.7451584507)
            //Modification du label positif
            cell.positifLabel.backgroundColor = UIColor.clear
            cell.positifLabel.text = voyageur.nomComplet
            
        }
        //Cas de la balance positive
        else{
           //Modification du label positif
            cell.montantPositifLabel.text = "\(balance) €"
            //Multiplicateur
            
            // Width constraint
            cell.positifLabel.addConstraint(NSLayoutConstraint(item: cell.positifLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(taille)))
            
            cell.positifLabel.backgroundColor = #colorLiteral(red: 0.004792788532, green: 0.4702310562, blue: 0.2677494586, alpha: 0.7521181778)
            //Modification du label négatif
            cell.negatifLabel.backgroundColor = UIColor.clear
            cell.negatifLabel.text = voyageur.nomComplet
        }
        return cell
    }
    
    
    
    //Calcul de la taille maximale que peut prendre une barre horizontale
    private func tailleMaxCell() -> Int{
        
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
            var balanceC = Int(balanceCourante)
            if (balanceC < 0){
                balanceC = balanceC * -1
            }
            
            return (tailleMax * balanceC) / balanceM
            
            
        }

    
    
    
}
