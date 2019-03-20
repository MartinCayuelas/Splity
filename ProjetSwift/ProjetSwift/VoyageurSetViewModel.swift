//
//  VoyageurSetViewModel.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 20/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

protocol VoyageurSetViewModelDelegate {
    // called when a voyage is added to the set
    func voyageurAdded(at index: IndexPath)
    // called when set globally changes
    func dataSetChanged()
}

class VoyageurSetViewModel : NSObject {

    var modelSet : VoyageurSet
    var data : [Voyageur]
    var delegate : VoyageurSetViewModelDelegate?
    
    override init() {
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
    }
    
    var count : Int {
        return self.data.count
    }
    
    
    func get(voyageurAt index: Int) -> Voyageur? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.data[index]
    }
    
    
    func add(voyageur: Voyageur){
        if self.modelSet.indexOf(v: voyageur) == nil{
            self.modelSet.add(v: voyageur)
            self.data.append(voyageur)
            self.delegate?.voyageurAdded(at: IndexPath(row: self.modelSet.count-1, section: 0))
        }
    }
    
}
