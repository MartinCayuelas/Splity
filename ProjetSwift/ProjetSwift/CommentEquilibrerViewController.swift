//
//  CommentEquilibrerViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 25/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class CommentEquilibrerViewController : UIViewController {
    
    @IBOutlet weak var bilanTableView: UITableView!
    var bilanTableViewController: BilanTableViewController!
    var voyageSelected: Voyage?
    
    @IBOutlet weak var dettesTableView: UITableView!
    var dettesTableViewController: DettesTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bilanTableViewController = BilanTableViewController(tableView: self.bilanTableView, voyageSelected: self.voyageSelected!)
        self.dettesTableViewController = DettesTableViewController(tableView: self.dettesTableView, voyageSelected: self.voyageSelected!)
    }
    
}
