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
    //let fetchResultController : VoyageFetchResultController
    
    init(tableView: UITableView, voyageSelected : Voyage){
        self.tableView = tableView
        self.voyageSelected = voyageSelected
        self.voyageurs = VoyageurSetViewModel(voyageurs: VoyageDAO.getAllVoyageurs(forVoyage: self.voyageSelected!))
        
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
        
        if balance < 0.0 {
            
            cell.labelNegatif.text = "\(balance) €"
            cell.labelPositif.text = voyageur.nomComplet
            cell.labelPositif.backgroundColor = UIColor.clear
            
        } else{
            cell.labelPositif.text = "+ \(balance) €"
            cell.labelNegatif.text = voyageur.nomComplet
            cell.labelNegatif.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    
    
    
    
}