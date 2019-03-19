//
//  VoyagesTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyagesTableViewController: NSObject, UITableViewDataSource{
    var nomVoyageur: String = ""
    var prenomVoyageur: String = ""
  
    var voyages : VoyageSetViewModel
    
    override init(){
        self.voyages = VoyageSetViewModel()
        print(self.voyages.count)
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

        cell.textLabel?.text = self.voyages.data[indexPath.row].titre
       cell.imageView?.image = UIImage(named: self.voyages.data[indexPath.row].image)
        return cell
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Voyages de " + prenomVoyageur + " " + nomVoyageur
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
