//
//  GestionVoyageursViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 28/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class GestionVoyageursViewController : UIViewController {
    
    var gestionVoyageursActifsTableViewController: GestionVoyageursActifsTableViewController!
    var gestionVoyageursInactifsTableViewController: GestionVoyageursInactifsTableViewController!
    var voyageSelected: Voyage?
    @IBOutlet weak var voyageursActifsTableView: UITableView!
    @IBOutlet weak var voyageursInactifsTableView: UITableView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gestionVoyageursActifsTableViewController = GestionVoyageursActifsTableViewController(tableView: self.voyageursActifsTableView, voyageSelected: self.voyageSelected!)
        self.gestionVoyageursInactifsTableViewController = GestionVoyageursInactifsTableViewController(tableView: self.voyageursInactifsTableView, voyageSelected: self.voyageSelected!)
    }
    
}
