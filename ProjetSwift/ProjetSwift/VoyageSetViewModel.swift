//
//  VoyageSetViewModel.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 18/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

protocol VoyageSetViewModelDelegate {
    func VoyageAdded(at:IndexPath)
}

class VoyageSetViewModel : NSObject {
    
    var modelSet : VoyageSet
    var data : [Voyage]
    override init() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
            else{
                fatalError()
        }
        guard let Voyages = delegate.voyagesTab else { fatalError()}
        self.modelSet = Voyages
        self.data = [Voyage]()
        for p in self.modelSet{
            self.data.append(p)
        }
        
    }
    
    var iterator : ItVoyageSet{
        return self.modelSet.makeIterator()
    }
    var count : Int {
        return self.data.count
    }
    
}
