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
    // called when set globally changes
    func dataSetChanged()
}

class VoyageurSetViewModel {//: NSObject {

    //var modelSet : VoyageurSet
    //var data : [Voyageur]
    var delegate : VoyageurSetViewModelDelegate?
    var voyageursFetched : NSFetchedResultsController<Voyageur>
    
    init(data: NSFetchedResultsController<Voyageur>){
        self.voyageursFetched = data
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
    
    var count : Int {
        return self.voyageursFetched.fetchedObjects?.count ?? 0
    }
    
    
    func get(voyageurAt index: Int) -> Voyageur? {
        return self.voyageursFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    
    func add(voyageur: Voyageur){
        if let indexPath = self.voyageursFetched.indexPath(forObject: voyageur){
            self.delegate?.voyageurAdded(at: indexPath)
        }
    }
    
}
