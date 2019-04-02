//
//  DetailVoyageController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 18/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DetailVoyageViewController: UIViewController{
    
    @IBOutlet weak var imageVoyage: UIImageView!
    @IBOutlet weak var titreVoyage: UILabel!
    @IBOutlet weak var labelDateVoyage: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelCoutTotal: UILabel!
    
    
    
    var voyageSelected : Voyage?
    var voyageurSelected : Voyageur?
    
    var balanceTableViewController: BalanceTableViewController!
    
    @IBOutlet weak var balanceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.balanceTableViewController = BalanceTableViewController(tableView: balanceTableView, voyageSelected : self.voyageSelected!)
        //Affichage de la balance pour le voyageur courant et le voyage courant
        var balance = VoyageDAO.getBalance(forVoyage: self.voyageSelected!, andVoyageur: self.voyageurSelected!)
        labelBalance.text = String(balance) + " €"
        if(balance < 0){
            labelBalance.textColor = UIColor(red:0.99, green:0.00, blue:0.00, alpha:1.0)
        } else {
            labelBalance.textColor = UIColor(red:0.22, green:0.46, blue:0.09, alpha:1.0)
        }
        
        //Affichage du coût total pour le voyageur courant et le voyage courant
        var coutTotal = VoyageDAO.getTotalRembourse(forVoyage: self.voyageSelected!, andVoyageur: self.voyageurSelected!)
        labelCoutTotal.text = String(coutTotal) + " €"
        
        if let avoyage = self.voyageSelected {
            self.titreVoyage
                .text = avoyage.titre
            
            let photoVoyage = UIImage(data: avoyage.photo as! Data)
          
            
         self.imageVoyage.image =  photoVoyage
            
            let df = DateFormatter()
            df.locale = Locale(identifier: "fr_FR")
            df.dateFormat = "dd/MM/yyyy"
            let stringDate = df.string(from: avoyage.dateDebut)
  
            if(avoyage.dateFin == nil){
                
                self.labelDateVoyage.text = "Commencé le \(stringDate)"
            }else{
                let df2 = DateFormatter()
                df2.locale = Locale(identifier: "fr_FR")
                df2.dateFormat = "dd/MM/yyyy"
                let stringDate2 = df2.string(from: avoyage.dateFin!)
                self.labelDateVoyage.text = "Du \(stringDate) au \(stringDate2)"
            }
            
        } else {
            self.titreVoyage.text = ""
           
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.balanceTableViewController.balanceMax = DepenseDAO.getBalanceMaximale(forVoyage: self.voyageSelected!)
        self.viewDidLoad()
        //self.balanceTableView.reloadData()
    }
    
    //Pour donner le voyage sélectionné à la page suivante (liste des dépenses)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? DepensesViewController {
            destController.voyageSelected = self.voyageSelected
        }
        if let destController = segue.destination as? GestionVoyageursViewController {
            destController.voyageSelected = self.voyageSelected
        }
        if let destController = segue.destination as? CommentEquilibrerViewController {
            destController.voyageSelected = self.voyageSelected
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
