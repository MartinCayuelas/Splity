//
//  VoyagesTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyagesTableViewController: NSObject, UITableViewDataSource, VoyageSetViewModelDelegate {
    var voyageurSelected: Voyageur?
  
    var tableView: UITableView!
    var voyages : VoyageSetViewModel
    //let fetchResultController : VoyageFetchResultController
    
    init(tableView: UITableView, voyageurSelected: Voyageur){
        self.voyageurSelected = voyageurSelected
        self.tableView = tableView
        //self.fetchResultController = VoyageFetchResultController(view : tableView)
        //self.voyages = VoyageSetViewModel(data: self.fetchResultController.voyagesFetched)
        self.voyages = VoyageSetViewModel(voyages: VoyageurDAO.getAllVoyages(forVoyageur: self.voyageurSelected!))
        super.init()
        self.tableView.dataSource = self
        self.voyages.delegate = self
    }

    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.voyages.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardVoyageCell", for: indexPath)
        
        guard let voyage = self.voyages.get(voyageAt: indexPath.row) else { return cell }
        
        cell.textLabel?.text = voyage.titre
        let photoVoyage = UIImage(data: voyage.photo as! Data)
        cell.imageView?.image = photoVoyage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            let voyage = self.voyages.get(voyageAt: indexPath.row)
            VoyageurDAO.quitterVoyage(forVoyageur: self.voyageurSelected!, andVoyage: voyage!)
            do {
                try VoyageurDAO.save()
            } catch {
                fatalError("Erreur à la suppression du programme.")
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.voyages.remove(voyage: voyage!)
            self.tableView.endUpdates()
        }
    }
    
    func voyageAdded(at index: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [index], with: UITableView.RowAnimation.middle)
        self.tableView.endUpdates()
    }
    
    func voyageDeleted(at index: IndexPath) {
        
    }
    
    func dataSetChanged() {
        self.tableView.reloadData()
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
