//
//  DettesTableViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 02/04/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DettesTableViewController : NSObject, UITableViewDataSource {
    
    var voyageursActifsTableView: UITableView!
    var voyageursActifsModel : VoyageurSetViewModel
    var voyageSelected: Voyage?
    var dettes: [[String]] = [[], [], []]
    
    init(tableView: UITableView, voyageSelected: Voyage) {
        self.voyageSelected = voyageSelected
        self.voyageursActifsTableView = tableView
        
        //On récupère les voyageurs actifs du voyage (participants ou ayant quittés)
        var voyageursActifs: [Voyageur] = VoyageDAO.getAllVoyageurs(forVoyage: voyageSelected)
        self.voyageursActifsModel = VoyageurSetViewModel(voyageurs: voyageursActifs)
        
        super.init()
        self.voyageursActifsTableView.dataSource = self
        
        //On lance le calcul des dettes pour remplir le tableau 'dettes'
        self.calculerDettes(forVoyageurs: voyageursActifs, andVoyage: voyageSelected)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voyageursActifsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cas des données
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardBilanCell", for: indexPath) as! BilanTableViewCell
        
        guard let voyageur = self.voyageursActifsModel.get(voyageurAt: indexPath.row-1) else { return cell }
        let paiements = VoyageDAO.getTotalPaye(forVoyage: self.voyageSelected!, andVoyageur: voyageur)
        let remboursements = VoyageDAO.getTotalRembourse(forVoyage: self.voyageSelected!, andVoyageur: voyageur)
        
        cell.nomCompletLabel.text = voyageur.nomComplet
        cell.paiementsLabel.text = "\(paiements) €"
        cell.remboursementsLabel.text = "\(remboursements) €"
        
        return cell
        
    }
    
    //Retourne le nom complet du voyageur avec la balance la plus faible
    private func getPlusGrosRembourseur(balances : [String : Double]) -> String {
        var min: Double = 0
        var nomVoyageurMin: String = ""
        for (cle, valeur) in balances{
            if valeur < min{
                min = valeur
                nomVoyageurMin = cle
            }
        }
        return nomVoyageurMin
    }
    
    //Retourne la balance du voyageur avec la balance la plus faible
    private func getMontantPlusGrosRembourseur(balances : [String : Double]) -> Double {
        var min: Double = 0
        for (cle, valeur) in balances{
            if valeur < min{
                min = valeur
            }
        }
        return min
    }
    
    //Retourne la balance du voyageur avec la balance la plus élevée
    private func getMontantPlusGrosPayeur(balances : [String : Double]) -> Double {
        var max: Double = 0
        for (cle, valeur) in balances{
            if valeur > max{
                max = valeur
            }
        }
        return max
    }
    
    //Retourne le nom complet du voyageur avec la balance la plus élevée
    private func getPlusGrosPayeur(balances : [String : Double]) -> String {
        var max: Double = 0
        var nomVoyageurMax: String = ""
        for (cle, valeur) in balances{
            if valeur > max{
                max = valeur
                nomVoyageurMax = cle
            }
        }
        return nomVoyageurMax
    }
    
    private func calculerDettes(forVoyageurs voyageurs: [Voyageur], andVoyage voyage: Voyage){
        //On remplit un tableau tampon avec pour chaque voyageur sa balance
        var balances: [String : Double] = [:]
        for v in voyageurs {
            balances[v.nomComplet] = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
        }
        print(balances)
        
        var fin: Bool = false
        //Tant que la balance n'est pas équilibrée
        while(!fin){
            //On récupère le voyageur ayant le plus de dettes
            var plusGrosRembourseur = self.getPlusGrosRembourseur(balances: balances)
            var montantPlusGrosRembourseur = self.getMontantPlusGrosRembourseur(balances: balances)
            
            //On récupère le voyageur ayant le moins de dettes
            var plusGrosPayeur = self.getPlusGrosPayeur(balances: balances)
            var montantPlusGrosPayeur = self.getMontantPlusGrosPayeur(balances: balances)
            
            print("PLUS GROS PAYEUR")
            print(plusGrosPayeur)
            print("MONTANT PLUS GROS PAYEUR")
            print(montantPlusGrosPayeur)
            print("PLUS GROS REMBOURSEUR")
            print(plusGrosRembourseur)
            print("MONTANT PLUS GROS REMBOURSEUR")
            print(montantPlusGrosRembourseur)
            
        }
    }
    
}
