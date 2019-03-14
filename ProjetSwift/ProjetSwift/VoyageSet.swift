//
//  VoyageSet.swift
//  ProjetSwift
//
//  Created by Nathan Guillaud on 14/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
class VoyageSet : Sequence{
    
    /// number of elements in the set
    var count: Int{
        return 0
    }

    @discardableResult
    func add(voyage: Voyage) -> VoyageSet{
        return self
    }

    @discardableResult
    func remove(voyage: Voyage) -> VoyageSet{
        return self
    }
    
    func look(forVoyage voyage: Voyage) -> Voyage?{
        return nil
    }

    func contains(voyageAvecTitre titre: String) -> Bool{
        return true
    }

    func look(voyagesAvecTitre titre: String) -> [Voyage]{
        return []
    }

    func indexOf(voyage: Voyage) -> Int?{
        return nil
    }
    
    func makeIterator() -> ItVoyageSet{
        return ItVoyageSet(self)
    }
    
}

/// Iterator on VoyageSet
struct ItVoyageSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Voyage]
    
    fileprivate init(_ s: VoyageSet){
        self.set = []
    }
    
    /// reset iterator
    /// - Returns: iterator reseted
    @discardableResult
    mutating func reset() -> ItVoyageSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Voyage? {
        return nil
    }
    
    /// true if iterator as finished
    var end : Bool{
        return true
    }
}
