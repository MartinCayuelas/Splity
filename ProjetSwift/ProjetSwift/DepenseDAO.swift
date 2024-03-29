//
//  DepenseDAO.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 26/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import CoreData

class DepenseDAO{
    static let request : NSFetchRequest<Depense> = Depense.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    
    /// Appelé lorsqu'un que l'on supprime un voyageur dans les données persistantes
    ///
    /// - Parameters: Depense
    static func delete(depense: Depense){
        CoreDataManager.context.delete(depense)
    }
    
    /// Appelé pour récuprer tous les voyages dans la base de données
    ///
    /// - Parameters: none
    static func fetchAll() -> [Depense]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
        
    }
    
    /// number of elements
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    static func count(forTitre titre: String) -> Int{
        self.request.predicate = NSPredicate(format: "titre == %@", titre)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    static func search(forTitre titre: String) -> [Depense]?{
        self.request.predicate = NSPredicate(format: "titre == %@", titre)
        do{
            return try CoreDataManager.context.fetch(request) as [Depense]
        }
        catch{
            return nil
        }
        
    }
    
    static func count(forDate date: Bool) -> Int{
        self.request.predicate = NSPredicate(format: "date == %@", date)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    static func search(forDate date: Bool) -> [Depense]?{
        self.request.predicate = NSPredicate(format: "date == %@", date)
        do{
            return try CoreDataManager.context.fetch(request) as [Depense]
        }
        catch{
            return nil
        }
        
    }
    
    static func count(depense: Depense) -> Int{
        
        self.request.predicate = NSPredicate(format: "titre == %@ AND date == %@",
                                             depense.titre, depense.date as CVarArg)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    
    static func search(forDepense depense: Depense) -> Depense?{
        self.request.predicate = NSPredicate(format: "titre == %@ AND date == %@",
                                             depense.titre, depense.date as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Depense]
            guard result.count != 0 else { return nil }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0]
        }
        catch{
            return nil
        }
        
    }
    
    static func ajouterPaiement(forDepense depense: Depense, andVoyageur voyageur: Voyageur, andMontant montant: Double) {
        _ = Payer(montant: montant, depense: depense, voyageur: voyageur)
    }
    
    static func ajouterRemboursement(forDepense depense: Depense, andVoyageur voyageur: Voyageur, andMontant montant: Double) {
        _ = Rembourser(montant: montant, depense: depense, voyageur: voyageur)
    }
    
    static func ajouterDepense(fortitre titre: String, andPhoto photo: NSData, andDate date: Date, andVoyage voyage: Voyage) -> Depense{
        let depense = Depense(titre: titre, photo: photo, date: date, voyage: voyage)
        return depense
    }
    
    static func insererMontantDepense(forDepense depense: Depense) {
        let requestPayer : NSFetchRequest<Payer> = Payer.fetchRequest()
        requestPayer.predicate = NSPredicate(format: "pDepense == %@", depense)
        do{
            let payeurs = try CoreDataManager.context.fetch(requestPayer) as [Payer]
            var montantTotal: Double = 0
            for case let p in payeurs  {
                montantTotal = montantTotal + p.montant
            }
            
            depense.setValue(montantTotal, forKey: "pMontantDepense")
            do{
                CoreDataManager.save()
            }
        }
        catch{
            
        }
        
    }
    
    static func getPayeursDepense(forDepense depense: Depense) -> [Voyageur]{
        
        
        let requestPayer : NSFetchRequest<Payer> = Payer.fetchRequest()
        requestPayer.predicate = NSPredicate(format: "pDepense == %@",
                                                  depense)
        do{
            let paiements = try CoreDataManager.context.fetch(requestPayer) as [Payer]
            var voyageurs: [Voyageur] = []
            for case let p  in paiements  {
                voyageurs.append(p.voyageur)
            }
            return voyageurs
        }
        catch{
            return []
        }
        
    }
    
    static func getMontant(forDepense depense: Depense, andPayeur voyageur: Voyageur) -> Double{
        
        let requestPayer : NSFetchRequest<Payer> = Payer.fetchRequest()
        requestPayer.predicate = NSPredicate(format: "pDepense == %@ AND pVoyageur == %@",depense,voyageur)
        do{
            let result = try CoreDataManager.context.fetch(requestPayer) as [Payer]
            guard result.count != 0 else { return 0 }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0].montant
        }
        catch{
            return 0
        }
        
    }
    
    static func getBalanceMaximale(forVoyage voyage: Voyage) -> Double{
        let voyageurs = VoyageDAO.getAllVoyageurs(forVoyage: voyage)
        var max : Double = 0
        for v in voyageurs{
            var balance = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
            if balance < 0.0{
                balance = balance * -1
            }
            if balance > max{
                max = balance
            }
        }
        return max
    }
    
    static func getPlusGrosPayeur(forVoyage voyage: Voyage) -> Voyageur {
        let voyageurs = VoyageDAO.getAllVoyageurs(forVoyage: voyage)
        var max: Double = 0
        var voyageurMax: Voyageur = voyageurs[0]
        for v in voyageurs{
            let balance = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
            if balance > max{
                max = balance
                voyageurMax = v
            }
        }
        return voyageurMax
    }
    
    static func getMontantPlusGrosPayeur(forVoyage voyage: Voyage) -> Double {
        let voyageurs = VoyageDAO.getAllVoyageurs(forVoyage: voyage)
        var max : Double = 0
        for v in voyageurs{
            let balance = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
            if balance > max{
                max = balance
            }
        }
        return max
    }
    
    static func getPlusGrosRembourseur(forVoyage voyage: Voyage) -> Voyageur {
        let voyageurs = VoyageDAO.getAllVoyageurs(forVoyage: voyage)
        var min: Double = 0
        var voyageurMin: Voyageur = voyageurs[0]
        for v in voyageurs{
            let balance = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
            if balance < min {
                min = balance
                voyageurMin = v
            }
        }
        return voyageurMin
    }
    
    static func getMontantPlusGrosRembourseur(forVoyage voyage: Voyage) -> Double {
        let voyageurs = VoyageDAO.getAllVoyageurs(forVoyage: voyage)
        var min : Double = 0
        for v in voyageurs{
            let balance = VoyageDAO.getBalance(forVoyage: voyage, andVoyageur: v)
            if balance < min{
                min = balance
            }
        }
        return min
    }
    
    
}
