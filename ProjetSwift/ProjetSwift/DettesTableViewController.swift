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
    var voyageSelected: Voyage?
    var dettes: [[String]] = [[], [], []]
    
    init(tableView: UITableView, voyageSelected: Voyage) {
        self.voyageSelected = voyageSelected
        self.voyageursActifsTableView = tableView
        
        //On récupère les voyageurs actifs du voyage (participants ou ayant quittés)
        let voyageursActifs: [Voyageur] = VoyageDAO.getAllVoyageurs(forVoyage: voyageSelected)
        
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
        return self.dettes[0].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cas des données
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardDetteCell", for: indexPath)
        
        let donneur = self.dettes[0][indexPath.row]
        let receveur = self.dettes[1][indexPath.row]
        let montant = self.dettes[2][indexPath.row]
        
        cell.textLabel?.text = donneur + " doit " + montant + " € à " + receveur
        
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
        for (_, valeur) in balances{
            if valeur < min{
                min = valeur
            }
        }
        return min
    }
    
    //Retourne la balance du voyageur avec la balance la plus élevée
    private func getMontantPlusGrosPayeur(balances : [String : Double]) -> Double {
        var max: Double = 0
        for (_, valeur) in balances{
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
    
    //Retourne true si toutes les dettes ont été équilibrées, false sinon
    private func estEquilibre(balances : [String : Double]) -> Bool {
        for (_, valeur) in balances{
            if valeur != 0 {
                return false
            }
        }
        return true
    }
    
    private func calculerDettes(forVoyageurs voyageurs: [Voyageur], andVoyage voyage: Voyage){
        //On remplit un tableau tampon avec pour chaque voyageur sa balance
        var balances: [String : Double] = [:]
        for v in voyageurs {
            balances[v.nomComplet] = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
        }
        print(balances)
        
        //Tant que la balance n'est pas équilibrée
        while(!estEquilibre(balances: balances)){
            //On récupère le voyageur ayant le plus de dettes
            let plusGrosRembourseur = self.getPlusGrosRembourseur(balances: balances)
            let montantPlusGrosRembourseur = self.getMontantPlusGrosRembourseur(balances: balances)
            
            //On récupère le voyageur ayant le moins de dettes
            let plusGrosPayeur = self.getPlusGrosPayeur(balances: balances)
            let montantPlusGrosPayeur = self.getMontantPlusGrosPayeur(balances: balances)
            
            var montantDetteCourante: Double = 0
            
            //Cas où le voyageur le plus en négatif a plus de dette que ce qu'à le voyageur le plus en positif
            if(montantPlusGrosRembourseur*(-1) > montantPlusGrosPayeur) {
                montantDetteCourante = montantPlusGrosPayeur
                balances[plusGrosPayeur] = 0
                balances[plusGrosRembourseur] = montantPlusGrosRembourseur + montantPlusGrosPayeur
            }
                //Cas où le voyageur le plus en négatif a moins de dette que ce qu'à le voyageur le plus en positif
            else {
                montantDetteCourante = montantPlusGrosRembourseur
                balances[plusGrosRembourseur] = 0
                balances[plusGrosPayeur] = montantPlusGrosPayeur + montantPlusGrosRembourseur
            }
            
            //Ajout de la dette dans la liste
            self.dettes[0].append(plusGrosRembourseur)
            self.dettes[1].append(plusGrosPayeur)
            if(montantDetteCourante < 0) {
                montantDetteCourante = montantDetteCourante * (-1)
            }
            self.dettes[2].append("\(montantDetteCourante)")
        }
    }
    
}

