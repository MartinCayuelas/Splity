//
//  VoyageSetViewModel.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 18/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol VoyageSetViewModelDelegate {
    // called when a voyage is added to the set
    func voyageAdded(at index: IndexPath)
    // called when set globally changes
    func dataSetChanged()
}

class VoyageSetViewModel : NSObject {
    
    //var modelSet : VoyageSet
    //var data : [Voyage]
    var delegate : VoyageSetViewModelDelegate?
    var voyagesConcernes : [Voyage]
    /*var voyagesFetched : NSFetchedResultsController<Voyage>
    
    init(data: NSFetchedResultsController<Voyage>){
        self.voyagesFetched = data
    }*/
    
    init(voyages: [Voyage]){
        self.voyagesConcernes = voyages
    }
    
    /*override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                fatalError()
        }
        guard let voyages = appDelegate.voyagesTab else { fatalError()}
        self.modelSet = voyages
        self.data = [Voyage]()
        for p in self.modelSet{
            self.data.append(p)
        }
        
    }
    
    convenience init(delegate : VoyageSetViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    var iterator : ItVoyageSet{
        return self.modelSet.makeIterator()
    }*/

    /// Compte le nombre de voyages dans la variable data -> Tableau de voyages
    ///
    /// - Parameter:  none
    /// - returns : un entier
    
    var count : Int {
        //return self.voyagesFetched.fetchedObjects?.count ?? 0
        return self.voyagesConcernes.count
    }
    
    
    /// Recupere un voyage au tableau des voyages (data)
    ///
    /// - Parameter:  index: un entier
    /// - returns : le voyage dans le tableau de data à la indexieme place
    
    func get(voyageAt index: Int) -> Voyage? {
        //return self.voyagesFetched.object(at: IndexPath(row: index, section: 0))
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.voyagesConcernes[index]
    }
    
        
    /// Ajoute une voyage au tableau des voyages (data)
    ///
    /// - Parameter:  voyage: un voyage
    /// - returns : 
    
    
    
    func add(voyage: Voyage){
        /*if let indexPath = self.voyagesFetched.indexPath(forObject: voyage){
         self.delegate?.voyageAdded(at: indexPath)
         }*/
        self.voyagesConcernes.append(voyage)
        self.delegate?.voyageAdded(at: IndexPath(row: self.voyagesConcernes.count-1, section: 0))
    }
}
