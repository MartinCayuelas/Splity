//
//  GestionVoyageursActifsTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 28/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class GestionVoyageursActifsTableViewController : NSObject, UITableViewDataSource {
    
    var voyageursActifsTableView: UITableView!
    var voyageurActifsModel : VoyageurSetViewModel
    var voyageSelected: Voyage?
    var voyageursTries: [[Voyageur]] = [[], []]
    
    
    
    init(tableView: UITableView, voyageSelected: Voyage) {
        self.voyageSelected = voyageSelected
        self.voyageursActifsTableView = tableView
        
        //On récupère les voyageurs actifs du voyage (participants ou ayant quittés)
        let voyageursActifs: [Voyageur] = VoyageDAO.getAllVoyageurs(forVoyage: voyageSelected)
        self.voyageurActifsModel = VoyageurSetViewModel(voyageurs: voyageursActifs)
        
        //On trie ces voyageurs en fonction de ceux qui sont actifs et ceux qui ont quittés
        for case let v  in voyageursActifs  {
            if(VoyageurDAO.isActif(forVoyageur: v, andVoyage: self.voyageSelected!)) {
                self.voyageursTries[0].append(v)
            }else{
                self.voyageursTries[1].append(v)
            }
        }
        
        super.init()
        self.voyageursActifsTableView.dataSource = self
        //self.voyageurModel.delegate = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Voyageurs actifs"
        } else {
            return "Voyageurs ayant quitté"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voyageursTries[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardVoyageursActifsCell", for: indexPath) as! GestionVoyageursActifsTableViewCell
        
        
        
        //guard let voyageur = self.voyageurActifsModel.get(voyageurAt: indexPath.row) else { return cell }
        cell.quitterVoyageBouton.isHidden = true
        cell.nomVoyageur?.text = self.voyageursTries[indexPath.section][indexPath.row].nom
        cell.prenomVoyageur?.text = self.voyageursTries[indexPath.section][indexPath.row].prenom
        return cell
        
    }
    
}
