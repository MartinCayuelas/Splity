//
//  DepenseSet.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DepenseSet : Sequence {
    
    fileprivate var depenseSet : [Depense] = []
    
    /// Initialise un DepenseSet vide
    init(){
        self.depenseSet = []
    }
    

    /// Initialise un DepenseSet
    ///
    /// - Parameter depenses: un tableau de dépenses
    ///
    init(depenses: [Depense]) {
        for d in depenses {
            self.depenseSet.append(d)
        }
    }
    
     /// Compte le nombre d'élément dans le DepenseSet
    ///
    /// 
    ///
    var count : Int {
        return self.depenseSet.count
    }
    
     /// Verifie si le depenseSet est vide
    ///
    /// - Parameter dSet: un depenseSet
    /// - return un booleen: vrai si vide, faux sinon
    func isEmpty(dSet: DepenseSet) -> Bool {
        return isEmpty(dSet: dSet)
    }
    
    /// Ajoute une depense au depenseSet
    ///
    /// - Parameter:  d: une depense
    /// - returns : le depenseSet avec la depense ajoutee

    func add(d: Depense) -> DepenseSet {
        if !self.depenseSet.contains(d){
            self.depenseSet.append(d)
        }
        return self
    }

    /// Supprime une depense au depenseSet
    ///
    /// - Parameter:  d: une depense
    /// - returns : le depenseSet avec la depense supprimee
    
    func remove(d: Depense) -> DepenseSet {
        if let i = self.depenseSet.index(of: d) {
            self.depenseSet.remove(at: i)
        }
        return self
    }
    
    /// Compte le nombre de depenses contenu dans le depenseSet
    ///
    /// - Parameter:  dSet: un depenseSet
    /// - returns : un entier correspondand au nombre d'éléments contenus 
    func count(dSet: DepenseSet) -> Int {
        return self.depenseSet.count
    }
    
    //Les méthodes look
    func look(forDepense d: Depense) -> Depense? {
        var it = self.makeIterator()
        while let dep = it.next() {
            if (dep == d){
                return dep
            }
        }
        return nil
    }
    
    
    
    //Les méthodes contains
    
    func contains(d: Depense) -> Bool {
        return self.depenseSet.contains(where: {$0==d})
    }
    
    
    
    func indexOf(d: Depense) -> Int? {
        guard self.count(dSet: self) > 0 else { return nil }
        var index : Int = 0
        var current : Depense = self.depenseSet[index]
        var found : Bool = (current == d)
        while ((index < self.count(dSet: self)) && !found){
            index += 1
            if (index < self.count(dSet: self)){
                current = self.depenseSet[index]
                found = (current == d)
            }
        }
        return found ? index : nil
    }
    
    public func makeIterator() -> ItDepenseSet {
        return ItDepenseSet(set: self)
    }
    
}

struct ItDepenseSet :IteratorProtocol{
    private var index: Int = 0
    private var set: DepenseSet
    
    fileprivate init(set: DepenseSet){
        self.set = set
        self = self.reset()
    }
    
    public mutating func reset() -> ItDepenseSet {
        self.index = 0
        return self
        
    }
    
    public mutating func next() -> Depense? {
        guard self.index < self.set.depenseSet.count else{
            return nil
        }
        let nextDepense = self.set.depenseSet[self.index]
        self.index += 1
        return nextDepense
    }
    
    func current() -> Depense? {
        if !end {
            return self.set.depenseSet[self.index]
        }
        return nil
    }
    
    public var end: Bool {
        return self.index < self.set.depenseSet.count
    }
    
    
}
