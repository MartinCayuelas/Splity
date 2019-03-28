//
//  VoyageurSetViewModel.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 20/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol VoyageurSetViewModelDelegate {
    // called when a voyage is added to the set
    func voyageurAdded(at index: IndexPath)
    // called when a voyage is removed to the set
    func voyageurDeleted(at index: IndexPath)
    // called when set globally changes
    func dataSetChanged()
}

class VoyageurSetViewModel {//: NSObject {

    //var modelSet : VoyageurSet
    //var data : [Voyageur]
    var delegate : VoyageurSetViewModelDelegate?
    /*var voyageursFetched : NSFetchedResultsController<Voyageur>
    
    
    
    init(data: NSFetchedResultsController<Voyageur>){
        
        //let archive = false
        //data.fetchRequest.predicate = NSPredicate(format: "archive == %@", archive)
        self.voyageursFetched = data
       // self.voyageursFetched.fetchRequest.predicate = NSPredicate(format: "archive == %@", archive)
    }*/
    
    var voyageursNonArchives : [Voyageur]
    
    init(voyageurs: [Voyageur]) {
        
        self.voyageursNonArchives = voyageurs
    }
    
    
    
    
    
    
    
    /*override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                fatalError()
        }
        guard let voyageurs = appDelegate.voyageursTab else { fatalError()}
        self.modelSet = voyageurs
        self.data = [Voyageur]()
        for v in self.modelSet{
            self.data.append(v)
        }
        
    }
    
    convenience init(delegate : VoyageurSetViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    var iterator : ItVoyageurSet{
        return self.modelSet.makeIterator()
    }*/
    
    
  /// Retourne le nombre de voyageurs
 /// 
 /// - Parameters: none
    var count : Int {
        //return self.voyageursFetched.fetchedObjects?.count ?? 0
        return self.voyageursNonArchives.count
    }
    
    /// Retourne le voyageur à l'index i
 /// 
 /// - Parameters: index 'Int'
    func get(voyageurAt index: Int) -> Voyageur? {
        //return self.voyageursFetched.object(at: IndexPath(row: index, section: 0))
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.voyageursNonArchives[index]
    }
    
    /// Ajoute un voyageur dans liste des voyageurs
 /// 
 /// - Parameters: voyageur 'Voyageur'
    func add(voyageur: Voyageur){
       /* if let indexPath = self.voyageursFetched.indexPath(forObject: voyageur){
            self.delegate?.voyageurAdded(at: indexPath)
        }*/
        
        print(voyageur.nomComplet)
        print( self.voyageursNonArchives.count-1)
        self.voyageursNonArchives.append(voyageur)
        self.delegate?.voyageurAdded(at: IndexPath(row: self.voyageursNonArchives.count-1, section: 0))
        CoreDataManager.save()
    }
    
    func remove(voyageur: Voyageur){
        /*if let indexPath = self.voyageursFetched.indexPath(forObject: voyageur){
            self.delegate?.voyageurDeleted(at: indexPath)
        }*/
        var index = self.voyageursNonArchives.lastIndex(of: voyageur)
        self.voyageursNonArchives.remove(at: index!)
        self.delegate?.voyageurDeleted(at: IndexPath(row: self.voyageursNonArchives.count-1, section: 0))
        CoreDataManager.save()
    }
    
}
