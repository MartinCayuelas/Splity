//
//  GestionVoyageursInactifsTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 28/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class GestionVoyageursInactifsTableViewController : NSObject, UITableViewDataSource {
    
    var voyageursInactifsTableView: UITableView!
    var voyageurModel : VoyageurSetViewModel
    var voyageSelected: Voyage?
    
    
    
    
    init(tableView: UITableView, voyageSelected: Voyage) {
        self.voyageSelected = voyageSelected
        self.voyageursInactifsTableView = tableView
        self.voyageurModel = VoyageurSetViewModel(voyageurs: VoyageDAO.getAllVoyageursAbsents(forVoyage: voyageSelected))
        
        super.init()
        self.voyageursInactifsTableView.dataSource = self
        //self.voyageurModel.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voyageurModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardVoyageursInactifsCell", for: indexPath) as! GestionVoyageursInactifsTableViewCell
        
        guard let voyageur = self.voyageurModel.get(voyageurAt: indexPath.row) else { return cell }
        
        cell.nomVoyageur.text = voyageur.nom
        cell.prenomVoyageur.text = voyageur.prenom
        
        return cell
    }
    
}
