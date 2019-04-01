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
    
    @IBAction func integrerVoyageur(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.voyageursInactifsTableView)
        if let indexPath = self.voyageursInactifsTableView.indexPathForRow(at: buttonPosition){
            voyageursInactifsTableView.beginUpdates()
            let voyageur = self.gestionVoyageursInactifsTableViewController.voyageurModel.get(voyageurAt: indexPath.row)
            VoyageurDAO.rejoindreVoyage(forVoyageur: voyageur!, andVoyage: self.voyageSelected!)
            self.gestionVoyageursInactifsTableViewController.voyageurModel.remove(voyageur: voyageur!)
            self.gestionVoyageursActifsTableViewController.voyageurActifsModel.add(voyageur: voyageur!)
            
            self.viewDidLoad()
            self.voyageursActifsTableView.reloadData()
            do {
                try VoyageurDAO.save()
            } catch {
                fatalError("Erreur à l'ajout dans le voyage.")
            }
            voyageursInactifsTableView.deleteRows(at: [indexPath], with: .fade)
            
            voyageursInactifsTableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gestionVoyageursActifsTableViewController = GestionVoyageursActifsTableViewController(tableView: self.voyageursActifsTableView, voyageSelected: self.voyageSelected!)
        self.gestionVoyageursInactifsTableViewController = GestionVoyageursInactifsTableViewController(tableView: self.voyageursInactifsTableView, voyageSelected: self.voyageSelected!)
    }
    
}
