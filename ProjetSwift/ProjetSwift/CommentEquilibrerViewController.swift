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
            
            //Reuperation de la cellule et du label
            let cell = self.dettesTableView.cellForRow(at: indexPath) as! EquilibreTableViewCell
            
            let result = cell.labelEquilibre.text!.split(separator: " ")
            
            let prenomDonneur = result[0]
            let nomDonneur = result[1]
            let prenomReceveur = result[6]
            let nomReceveur = result[7]
            let montantDepense = result[3]
            
            
            //Recherche des donneurs et receveurs
            let receveur = VoyageurDAO.search(forPrenom: String(prenomReceveur), nom: String(nomReceveur))
            let donneur = VoyageurDAO.search(forPrenom: String(prenomDonneur), nom: String(nomDonneur))
            
            //Creation Depense, Payer et Rembourser
            let titre = "Remboursement \(prenomDonneur) à \(prenomReceveur)"
            
            
            let imageData = UIImagePNGRepresentation(UIImage(named: "cash")!)
            
            let depense = DepenseDAO.ajouterDepense(fortitre: titre, andPhoto: imageData! as NSData, andDate: Date(), andVoyage: self.voyageSelected!)
            
            DepenseDAO.ajouterPaiement(forDepense: depense, andVoyageur: donneur![0], andMontant: Double(montantDepense)!)
            DepenseDAO.ajouterRemboursement(forDepense: depense, andVoyageur: receveur![0], andMontant: Double(montantDepense)!)
            
            DepenseDAO.insererMontantDepense(forDepense: depense)
            
            CoreDataManager.save()
            
            //Suppression cellule
            /*self.dettesTableView.beginUpdates()
            self.dettesTableView.deleteRows(at: [indexPath], with: .fade)
            self.dettesTableView.endUpdates()*/
            
        }
    }
    
    
}
