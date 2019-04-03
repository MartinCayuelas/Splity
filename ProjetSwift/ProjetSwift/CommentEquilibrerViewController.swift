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
    
    @IBAction func payerDette(_ sender: UIButton) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.dettesTableView)
        if let indexPath = self.dettesTableView.indexPathForRow(at: buttonPosition){
            
            let cell = self.dettesTableView.cellForRow(at: indexPath) as! EquilibreTableViewCell
            
            
            let result = cell.labelEquilibre.text!.split(separator: " ")
            
            let prenomDonneur = result[0]
            let nomDonneur = result[1]
            let prenomReceveur = result[6]
            let nomReceveur = result[7]
            let montantDepense = result[3]
            
            print(prenomDonneur)
             print(prenomReceveur)
             print(montantDepense)
            
        }
    }
    
    
}
