//
//  VoyageurDAO.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

import CoreData

class VoyageurDAO{
    static let request : NSFetchRequest<Voyageur> = Voyageur.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    
    /// Appelé lorsqu'un que l'on supprime un voyageur dans les données persistantes
    /// 
    /// - Parameters: Voyageur
    static func delete(voyageur: Voyageur){
        CoreDataManager.context.delete(voyageur)
    }
    
    /// Appelé pour récuprer tous les voyegeurs dans la base de données
    /// 
    /// - Parameters: none
    static func fetchAll() -> [Voyageur]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        } }
    
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
    static func count(forPrenom prenom: String) -> Int{
        self.request.predicate = NSPredicate(format: "prenom == %@", prenom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    static func search(forPrenom prenom: String) -> [Voyageur]?{
        self.request.predicate = NSPredicate(format: "prenom == %@", prenom)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyageur]
        }
        catch{
            return nil
        }
        
    }
    static func count (forNom nom: String) -> Int{
        self.request.predicate = NSPredicate(format: "nom == %@", nom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    static func search(forNom nom: String) -> [Voyageur]?{
        self.request.predicate = NSPredicate(format: "nom == %@", nom)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyageur]
        }
        catch{
            return nil
        }
        
    }
    static func count(forPrenom prenom: String, nom: String) -> Int{
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@", prenom, nom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    static func search(forPrenom prenom: String, nom: String) -> [Voyageur]?{
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@", prenom, nom)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyageur]
        }
        catch{
            return nil
        } }
    
    static func count(voyageur: Voyageur) -> Int{
        
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@",
                                             voyageur.prenom, voyageur.nom as CVarArg)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    
    static func search(forVoyageur voyageur: Voyageur) -> Voyageur?{
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@",
                                             voyageur.prenom, voyageur.nom as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Voyageur]
            guard result.count != 0 else { return nil }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0]
        }
        catch{
            return nil
        }
        
    }
    
    static func getAllVoyages(forVoyageur voyageur: Voyageur) -> [Voyage] {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyageur == %@",
                                                  voyageur)
        do{
            let participations = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            var voyages: [Voyage] = []
            for case let participation in participations  {
                voyages.append(participation.voyage)
            }
            return voyages
        }
        catch{
            return []
        }
    }
    
    
    static func getAllParticipations(forVoyageur voyageur: Voyageur) -> [Participer] {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyageur == %@",
                                                  voyageur)
        do{
            return try CoreDataManager.context.fetch(requestParticiper) as [Participer]
        }
        catch{
            return []
        }
    }
    
    static func terminerParticipations(forVoyageur voyageur: Voyageur){
        let participations : [Participer] = getAllParticipations(forVoyageur: voyageur)
        
        for case let participation  in participations  {
            
            let p = participation as NSManagedObject
            p.setValue(Date(), forKey: "pDateDepart")
            do{
                 CoreDataManager.save()
            }
            
        }
    }
    
    
    //GET Voyageurs non archives
    static func getAllVoyageursNonArchives() -> [Voyageur] {
       
       self.request.predicate = NSPredicate(format: "pArchive == false")
        do{
            return try CoreDataManager.context.fetch(self.request) as [Voyageur]
        }
        catch{
            return []
        }
    }
    
    static func archiver(forVoyageur voyageur: Voyageur){
        let v = voyageur as NSManagedObject
        v.setValue(true, forKey: "pArchive")
    }
    
    static func quitterVoyage(forVoyageur voyageur: Voyageur, andVoyage voyage: Voyage) {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyageur == %@ AND pVoyage == %@", voyageur, voyage)
        do{
            let result = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            guard result.count == 1 else { fatalError("duplicate entries") }
            
            result[0].setValue(Date(), forKey: "pDateDepart")
            do{
                 CoreDataManager.save()
            }
        }
        catch{
            
        }
    }
    
    static func rejoindreVoyage(forVoyageur voyageur: Voyageur, andVoyage voyage: Voyage) {
        _ = Participer(dateArrivee: Date(), dateDepart: nil, voyage: voyage, voyageur: voyageur)
    }
    
    static func isActif(forVoyageur voyageur: Voyageur, andVoyage voyage: Voyage) -> Bool {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyageur == %@ AND pVoyage == %@", voyageur, voyage)
        do{
            let result = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            guard result.count != 0 else { return false }
            guard result.count == 1 else { fatalError("duplicate entries") }
            if(result[0].dateDepart == nil){
                return true
            } else {
                return false
            }
        }
        catch{
            return false
        }
    }
    
    static func getAllVoyagesActifs(forVoyageur voyageur: Voyageur) -> [Voyage] {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyageur == %@ AND pDateDepart == nil",
                                                  voyageur)
        do{
            let participations = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            var voyages: [Voyage] = []
            for case let participation  in participations  {
                voyages.append(participation.voyage)
            }
            return voyages
        }
        catch{
            return []
        }
    }
    
    static func getDateDepart(forVoyageur voyageur: Voyageur, andVoyage voyage : Voyage) -> Date? {
        let requestParticiper : NSFetchRequest<Participer> = Participer.fetchRequest()
        requestParticiper.predicate = NSPredicate(format: "pVoyageur == %@ AND pVoyage == %@", voyageur, voyage)
        do{
            let result = try CoreDataManager.context.fetch(requestParticiper) as [Participer]
            guard result.count != 0 else { return nil }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0].dateDepart
        }
        catch{
            return nil
        }
    }
    
}
