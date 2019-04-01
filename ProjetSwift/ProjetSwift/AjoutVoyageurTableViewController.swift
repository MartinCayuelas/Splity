//
//  AjoutVoyageurTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 25/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutVoyageurTableViewController: NSObject, UITableViewDataSource, VoyageurSetViewModelDelegate {
    func voyageurDeleted(at index: IndexPath) {
       
    }
    
    func voyageurAdded(at index: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [index], with: UITableView.RowAnimation.middle)
        self.tableView.endUpdates()
    }
    
    
    var tableView: UITableView!
    var voyageurs : VoyageurSetViewModel
    var voyageurSelected : Voyageur?
    
    init(tableView: UITableView, voyageur : Voyageur){
        self.tableView = tableView
        self.voyageurs = VoyageurSetViewModel(voyageurs: VoyageurDAO.getAllVoyageursNonArchives())
        self.voyageurSelected = voyageur
        voyageurs.remove(voyageur: voyageurSelected!)
        super.init()
        self.tableView.dataSource = self
        self.voyageurs.delegate = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardVoyageurCell", for: indexPath) as! AjoutVoyageurTableViewCell
        
        guard let voyageur = self.voyageurs.get(voyageurAt: indexPath.row) else { return cell }
        
        cell.nomVoyageur.text = voyageur.nom
        cell.prenomVoyageur.text = voyageur.prenom

        
        
        return cell
    }
    
    func voyageAdded(at index: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [index], with: UITableView.RowAnimation.middle)
        self.tableView.endUpdates()
    }
    
    func dataSetChanged() {
        self.tableView.reloadData()
    }
}
