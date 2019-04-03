//
//  DepenseSetViewModel.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol DepenseSetViewModelDelegate {
    // called when a depense is added to the set
    func depenseAdded(at index: IndexPath)
    // called when a depense is deleted to the set
    func depenseDeleted(at index: IndexPath)
    // called when set globally changes
    func dataSetChanged()
}

class DepenseSetViewModel : NSObject {
    
    //var modelSet : DepenseSet
    //var data : [Depense]
    var delegate : DepenseSetViewModelDelegate?
    /*var depensesFetched : NSFetchedResultsController<Depense>
    
    init(data: NSFetchedResultsController<Depense>){
        self.depensesFetched = data
    }*/
    
    var depensesConcernees : [Depense]
    
    init(depenses: [Depense]){
        self.depensesConcernees = depenses
    }
    
    /*
    override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                fatalError()
        }
        guard let depenses = appDelegate.depensesTab else { fatalError()}
        self.modelSet = depenses
        self.data = [Depense]()
        for d in self.modelSet{
            self.data.append(d)
        }
        
    }
    
    convenience init(delegate : DepenseSetViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    var iterator : ItDepenseSet{
        return self.modelSet.makeIterator()
    }
    */

    /// Compte le nombre de depense dans la variable data -> Tableau de depenses
    ///
    /// - Parameter:  none
    /// - returns : un entier
    var count : Int {
        //return self.depensesFetched.fetchedObjects?.count ?? 0
        return self.depensesConcernees.count
    }
    
    /// Recupere une depense au tableau des depenses (data)
    ///
    /// - Parameter:  index: un entier
    /// - returns : la depense dans le tableau de data à la indexieme place
    
    func get(depenseAt index: Int) -> Depense? {
        //return self.depensesFetched.object(at: IndexPath(row: index, section: 0))
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.depensesConcernees[index]
    }
    
    /// Ajoute une depense au tableau des depenses (data)
    ///
    /// - Parameter:  depense: une depense
    /// - returns : 
    
    
    func add(depense: Depense){
       /* if let indexPath = self.depensesFetched.indexPath(forObject: depense){
            self.delegate?.depenseAdded(at: indexPath)
        }*/
        self.depensesConcernees.append(depense)
        self.delegate?.depenseAdded(at: IndexPath(row: self.depensesConcernees.count-1, section: 0))
        CoreDataManager.save()
    }
    
    func remove(depense: Depense){
        /*if let indexPath = self.voyageursFetched.indexPath(forObject: voyageur){
         self.delegate?.voyageurDeleted(at: indexPath)
         }*/
        let index = self.depensesConcernees.lastIndex(of: depense)
        self.depensesConcernees.remove(at: index!)
        self.delegate?.depenseDeleted(at: IndexPath(row: self.depensesConcernees.count-1, section: 0))
        CoreDataManager.save()
    }
    
}
