//
//  AjoutDepenseRembourseurTableViewController.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 01/04/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutDepenseRembourseurTableViewController: NSObject, UITableViewDataSource {
    
    var voyageSelected : Voyage?
    
    func dataSetChanged() {}
    
    func voyageurDeleted(at index: IndexPath) {}
    
    func voyageurAdded(at index: IndexPath) {}
    
    var tableView: UITableView!
    var voyageurs : VoyageurSetViewModel
    // let fetchResultController : VoyageurFetchResultController
    
    init(tableView: UITableView, voyageSelected : Voyage){
        self.tableView = tableView
        self.voyageurs = VoyageurSetViewModel(voyageurs: VoyageDAO.getAllVoyageurs(forVoyage: voyageSelected))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardRembourseurCell", for: indexPath) as! AjoutDepenseRembourseurCell
        
        guard let voyageur = self.voyageurs.get(voyageurAt: indexPath.row) else { return cell }
        
        
       cell.nomVoyageur.text = voyageur.nomComplet
        //cell.montantDepense.text = " 0 €"
        
        return cell
    }
    
}
