//
//  VoyagesTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyagesTableViewController: NSObject, UITableViewDataSource, VoyageSetViewModelDelegate {
    var nomVoyageur: String = ""
    var prenomVoyageur: String = ""
  
    @IBOutlet weak var tableView: UITableView!
    var voyages : VoyageSetViewModel
    
    override init(){
        self.voyages = VoyageSetViewModel()
        super.init()
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
        cell.imageView?.image = UIImage(named: voyage.image)
        cell.textLabel?.textColor = UIColor(red:0.15, green:0.50, blue:0.75, alpha:1.0)
        
        
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
