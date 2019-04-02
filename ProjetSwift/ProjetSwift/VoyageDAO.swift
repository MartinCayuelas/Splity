//
//  VoyageDAO.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 25/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import CoreData

class VoyageDAO{
    static let request : NSFetchRequest<Voyage> = Voyage.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    
    /// Appelé lorsqu'un que l'on supprime un voyageur dans les données persistantes
    ///
    /// - Parameters: Voyage
    static func delete(voyage: Voyage){
        CoreDataManager.context.delete(voyage)
    }
    
    /// Appelé pour récuprer tous les voyages dans la base de données
    ///
    /// - Parameters: none
    static func fetchAll() -> [Voyage]?{
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
    static func search(forTitre titre: String) -> [Voyage]?{
        self.request.predicate = NSPredicate(format: "titre == %@", titre)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyage]
        }
        catch{
            return nil
        }
        
    }
    
    static func count(forActif actif: Bool) -> Int{
        self.request.predicate = NSPredicate(format: "actif == %@", actif)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    static func search(forActif actif: Bool) -> [Voyage]?{
        self.request.predicate = NSPredicate(format: "actif == %@", actif)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyage]
        }
        catch{
            return nil
        }
        
    }
    
    static func count(voyage: Voyage) -> Int{
        
        self.request.predicate = NSPredicate(format: "titre == %@ AND photo == %@",
                                             voyage.titre, voyage.photo as CVarArg)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    
    static func search(forVoyage voyage: Voyage) -> Voyage?{
        self.request.predicate = NSPredicate(format: "titre == %@ AND photo == %@",
                                             voyage.titre, voyage.photo as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Voyage]
            guard result.count != 0 else { return nil }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0]
        }
        catch{
            return nil
        }
        
    }
    
    static func getAllDepenses(forVoyage voyage: Voyage) -> [Depense] {
        let requestDepense : NSFetchRequest<Depense> = Depense.fetchRequest()
        requestDepense.predicate = NSPredicate(format: "pVoyage == %@",
                                                  voyage)
        do{
            return try CoreDataManager.context.fetch(requestDepense) as [Depense]
        }
        catch{
            return []
        }
    }

    static func getAllVoyageurs(forVoyage voyage: Voyage) -> [Voyageur] {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyage == %@",
                                                  voyage)
        do{
            var participations = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            var voyageurs: [Voyageur] = []
            for case let participation as Participer in participations  {
                voyageurs.append(participation.voyageur)
            }
            return voyageurs
        }
        catch{
            return []
        }
    }
    
    static func getAllVoyageursActifs(forVoyage voyage: Voyage) -> [Voyageur] {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyage == %@ AND pDateDepart == nil",voyage)
        do{
            var participations = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            var voyageurs: [Voyageur] = []
            for case let participation as Participer in participations  {
                voyageurs.append(participation.voyageur)
            }
            return voyageurs
        }
        catch{
            return []
        }
    }
    
    static func getAllVoyageursAbsents(forVoyage voyage: Voyage) -> [Voyageur] {
        var voyageursPresents: [Voyageur] = self.getAllVoyageurs(forVoyage: voyage)
        //On ne veut que les voyageurs non archivés
        var voyageurs: [Voyageur] = VoyageurDAO.getAllVoyageursNonArchives()
        
        var voyageursAbsents: [Voyageur]? = []
        
        //on parcourt l'ensemble des voyageurs
        for case let v as Voyageur in voyageurs {
            var trouve: Bool = false
            var i: Int = 0
            //On s'arrête dans l'un de ces 2 cas
            //lorsqu'on a parcouru l'ensemble des voyageurs présents
            //lorsqu'on trouve le voyageur courant dans la liste des voyageurs présents au voyage
            while(!trouve && i < (voyageursPresents.count)){
                if(v.isEqual(voyageursPresents[i])){
                    trouve = true
                }
                i = i + 1
            }
            //si le voyageur n'a pas été trouvé dans la liste des voyageurs présents
            if(trouve == false){
                voyageursAbsents?.append(v)
            }
        }
        return voyageursAbsents!
    }
    
    // Retourne le montant total d'un voyage
    static func getMontant(forVoyage voyage: Voyage) -> Double {
        let requestPayer : NSFetchRequest<Payer> = Payer.fetchRequest()
        requestPayer.predicate = NSPredicate(format: "pDepense.pVoyage == %@",voyage)
        do{
            var paiements = try CoreDataManager.context.fetch(requestPayer) as [Payer]
            var montantTotal: Double = 0
            for case let p as Payer in paiements {
                montantTotal = montantTotal + p.montant
            }
            return montantTotal
        }
        catch{
            return 0
        }
    }
    
    //Retourne le montant total payé par un voyageur pour un voyage
    static func getTotalPaye(forVoyage voyage: Voyage, andVoyageur voyageur: Voyageur) -> Double {
        let requestPayer : NSFetchRequest<Payer> = Payer.fetchRequest()
        requestPayer.predicate = NSPredicate(format: "pDepense.pVoyage == %@ AND pVoyageur == %@",voyage,voyageur)
        do{
            var paiements = try CoreDataManager.context.fetch(requestPayer) as [Payer]
            var montantTotal: Double = 0
            for case let p as Payer in paiements {
                montantTotal = montantTotal + p.montant
            }
            return montantTotal
        }
        catch{
            return 0
        }
    }
    
    //Retourne le montant total à rembourser par un voyageur pour un voyage
    static func getTotalRembourse(forVoyage voyage: Voyage, andVoyageur voyageur: Voyageur) -> Double {
        let requestRembourser : NSFetchRequest<Rembourser> = Rembourser.fetchRequest()
        requestRembourser.predicate = NSPredicate(format: "pDepense.pVoyage == %@ AND pVoyageur == %@",voyage,voyageur)
        do{
            var remboursements = try CoreDataManager.context.fetch(requestRembourser) as [Rembourser]
            var montantTotal: Double = 0
            for case let r as Rembourser in remboursements {
                montantTotal = montantTotal + r.montant
            }
            return montantTotal
        }
        catch{
            return 0
        }
    }
    
    //Retourne la balance d'un voyageur pour un voyage
    static func getBalance(forVoyage voyage: Voyage, andVoyageur voyageur: Voyageur) -> Double {
        return getTotalPaye(forVoyage: voyage, andVoyageur: voyageur) - getTotalRembourse(forVoyage: voyage, andVoyageur: voyageur)
    }
    
}
