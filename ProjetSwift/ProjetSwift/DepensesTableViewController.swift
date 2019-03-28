//
//  DepensesTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DepensesTableViewController : NSObject, UITableViewDataSource, DepenseSetViewModelDelegate {
    
    var depensesTableView: UITableView!
    var depensesModel : DepenseSetViewModel
    let fetchResultController : DepenseFetchResultController
    
    init(tableView: UITableView) {
        self.depensesTableView = tableView
        self.fetchResultController = DepenseFetchResultController(view : tableView)
        self.depensesModel = DepenseSetViewModel(data: self.fetchResultController.depensesFetched)
        super.init()
        self.depensesTableView.dataSource = self
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
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.dateFormat = "dd/MM/yyyy"
        let stringDate = df.string(from: depense.date)
        
        cell.textLabel?.text = depense.titre
        cell.detailTextLabel?.text = String(depense.montant)+" €"
        
        if(depense.montant > 100.0){
            cell.detailTextLabel?.textColor = UIColor(red:0.99, green:0.00, blue:0.00, alpha:1.0)
        } else{
            cell.detailTextLabel?.textColor = UIColor(red:0.22, green:0.46, blue:0.09, alpha:1.0)
        }
        
        
        
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
