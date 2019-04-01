//
//  AjoutDepensePayeurTableViewController.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 29/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutDepensePayeurTableViewController: NSObject, UITableViewDataSource {
    
    func dataSetChanged() {}
    
    func voyageurDeleted(at index: IndexPath) {}
    
    func voyageurAdded(at index: IndexPath) {}
    
    var tableView: UITableView!
    var voyageurs : VoyageurSetViewModel
    // let fetchResultController : VoyageurFetchResultController
    
    var voyageSelected : Voyage?
    
    init(tableView: UITableView, voyageSelected: Voyage){
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardPayeurCell", for: indexPath) as! AjoutDepensePayeurCell
        
        guard let voyageur = self.voyageurs.get(voyageurAt: indexPath.row) else { return cell }
        
        
        cell.nomVoyageur.text = voyageur.nomComplet
        //cell.montantDepense.text = " 0 €"
        
        return cell
    }
    

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    //MARK: - Navigation
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     
     */
}
