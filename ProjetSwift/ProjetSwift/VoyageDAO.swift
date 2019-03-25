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
}
