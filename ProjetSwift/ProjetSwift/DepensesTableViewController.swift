//
//  DepensesTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DepenseTableViewController : NSObject, UITableViewDataSource, DepenseSetViewModelDelegate {
    
    @IBOutlet weak var depensesTableView: UITableView!
    var depensesModel : DepenseSetViewModel
    
    override init() {
        self.depensesModel = DepenseSetViewModel()
        super.init()
        self.depensesModel.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.depensesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = depensesTableView.dequeueReusableCell(withIdentifier: "standardDepenseCell", for: indexPath)
        
        guard let depense = self.depensesModel.get(depenseAt: indexPath.row) else { return cell }
        
        //cell.textLabel?.text = voyageur.nom
        //cell.detailTextLabel?.text = voyageur.prenom
        
        return cell
    }
    
    func depenseAdded(at index: IndexPath) {
        self.depensesTableView.beginUpdates()
        self.depensesTableView.insertRows(at: [index], with: UITableView.RowAnimation.middle)
        self.depensesTableView.endUpdates()
    }
    
    func dataSetChanged() {
        self.depensesTableView.reloadData()
    }

}
