//
//  VoyageurTableViewController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 20/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyageursTableViewController: NSObject, UITableViewDataSource, VoyageurSetViewModelDelegate {
    
    

    var voyageursTableView: UITableView!
    var voyageurs : VoyageurSetViewModel
    //let fetchResultController : VoyageurFetchResultController
    
    
    init(tableView: UITableView){
        self.voyageursTableView = tableView
      //  self.fetchResultController = VoyageurFetchResultController(view : tableView)
    
     // self.voyageurs = VoyageurSetViewModel(data: self.fetchResultController.voyageursFetched)
        self.voyageurs = VoyageurSetViewModel(voyageurs: VoyageurDAO.getAllVoyageursNonArchives())
        
        super.init()
        self.voyageursTableView.dataSource = self
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
        let cell = voyageursTableView.dequeueReusableCell(withIdentifier: "standardVoyageurCell", for: indexPath)

        guard let voyageur = self.voyageurs.get(voyageurAt: indexPath.row) else { return cell }
        
        cell.textLabel?.text = voyageur.nom
        cell.detailTextLabel?.text = voyageur.prenom

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           self.voyageursTableView.beginUpdates()
            let v = self.voyageurs.get(voyageurAt: indexPath.row)!
            VoyageurDAO.terminerParticipations(forVoyageur: v)
            VoyageurDAO.archiver(forVoyageur: v)
           // VoyageurDAO.delete(voyageur: v)
    
            do {
                try VoyageurDAO.save()
            } catch {
                fatalError("Erreur à la suppression du programme.")
            }
            self.voyageursTableView.deleteRows(at: [indexPath], with: .fade)
            self.voyageurs.remove(voyageur: v)
            //voyageurs.remove(at: indexPath.row)
            self.voyageursTableView.endUpdates()
        }
    }
    
    func voyageurAdded(at index: IndexPath) {
        self.voyageursTableView.beginUpdates()
        self.voyageursTableView.insertRows(at: [index], with: UITableView.RowAnimation.middle)
        self.voyageursTableView.endUpdates()
    }
    
    func voyageurDeleted(at index: IndexPath) {
        
    }
    
    func dataSetChanged() {
        self.voyageursTableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
