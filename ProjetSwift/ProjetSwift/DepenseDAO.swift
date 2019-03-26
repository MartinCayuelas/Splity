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
}
