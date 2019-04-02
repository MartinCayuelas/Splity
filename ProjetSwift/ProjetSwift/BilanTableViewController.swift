//
//  BilanTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 02/04/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class BilanTableViewController : NSObject, UITableViewDataSource {
    
    var voyageursActifsTableView: UITableView!
    var voyageursActifsModel : VoyageurSetViewModel
    var voyageSelected: Voyage?
    
    init(tableView: UITableView, voyageSelected: Voyage) {
        self.voyageSelected = voyageSelected
        self.voyageursActifsTableView = tableView
        
        //On récupère les voyageurs actifs du voyage (participants ou ayant quittés)
        var voyageursActifs: [Voyageur] = VoyageDAO.getAllVoyageurs(forVoyage: voyageSelected)
        self.voyageursActifsModel = VoyageurSetViewModel(voyageurs: voyageursActifs)
        
        super.init()
        self.voyageursActifsTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voyageursActifsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardBilanCell", for: indexPath) as! BilanTableViewCell
        
        
        
        guard let voyageur = self.voyageursActifsModel.get(voyageurAt: indexPath.row) else { return cell }
        let paiements = VoyageDAO.getTotalPaye(forVoyage: self.voyageSelected!, andVoyageur: voyageur)
        let remboursements = VoyageDAO.getTotalRembourse(forVoyage: self.voyageSelected!, andVoyageur: voyageur)
        
        cell.nomCompletLabel.text = voyageur.nomComplet
        cell.paiementsLabel.text = "\(paiements) €"
        cell.remboursementsLabel.text = "\(remboursements) €"
        
        return cell
        
    }
    
}
