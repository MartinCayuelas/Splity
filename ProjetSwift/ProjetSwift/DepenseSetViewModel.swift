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
    // called when set globally changes
    func dataSetChanged()
}

class DepenseSetViewModel : NSObject {
    
    //var modelSet : DepenseSet
    //var data : [Depense]
    var delegate : DepenseSetViewModelDelegate?
    var depensesFetched : NSFetchedResultsController<Depense>
    
    init(data: NSFetchedResultsController<Depense>){
        self.depensesFetched = data
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
        return self.depensesFetched.fetchedObjects?.count ?? 0
    }
    
    /// Recupere une depense au tableau des depenses (data)
    ///
    /// - Parameter:  index: un entier
    /// - returns : la depense dans le tableau de data à la indexieme place
    
    func get(depenseAt index: Int) -> Depense? {
        return self.depensesFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    /// Ajoute une depense au tableau des depenses (data)
    ///
    /// - Parameter:  depense: une depense
    /// - returns : 
    
    
    func add(depense: Depense){
        if let indexPath = self.depensesFetched.indexPath(forObject: depense){
            self.delegate?.depenseAdded(at: indexPath)
        }
    }
    
}
