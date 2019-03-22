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
    
    init(){
        self.depenseSet = []
    }
    
    init(depenses: [Depense]) {
        for d in depenses {
            self.depenseSet.append(d)
        }
    }
    
    var count : Int {
        return self.depenseSet.count
    }
    
    func isEmpty(dSet: DepenseSet) -> Bool {
        return isEmpty(dSet: dSet)
    }
    
    func add(d: Depense) -> DepenseSet {
        if !self.depenseSet.contains(d){
            self.depenseSet.append(d)
        }
        return self
    }
    
    func remove(d: Depense) -> DepenseSet {
        if let i = self.depenseSet.index(of: d) {
            self.depenseSet.remove(at: i)
        }
        return self
    }
    
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
