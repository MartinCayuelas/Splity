//
//  VoyageSet.swift
//  ProjetSwift
//
//  Created by Nathan Guillaud on 14/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class VoyageSet: Sequence {
    
    fileprivate var VoyageSet : [Voyage] = []
    
    init(){
        self.VoyageSet = []
    }
    
    init(Voyages: [Voyage]) {
        for p in Voyages {
            self.VoyageSet.append(p)
        }
    }
    
    var count : Int {
        return self.VoyageSet.count
    }
    
    func isEmpty(pSet: VoyageSet) -> Bool {
        return isEmpty(pSet: pSet)
    }
    
    func add(p: Voyage) -> VoyageSet {
        if !self.VoyageSet.contains(p){
            self.VoyageSet.append(p)
        }
        return self
    }
    
    func remove(p: Voyage) -> VoyageSet {
        if let i = self.VoyageSet.index(of: p) {
            self.VoyageSet.remove(at: i)
        }
        return self
    }
    
    func count(pSet: VoyageSet) -> Int {
        return self.VoyageSet.count
    }
    
    //Les méthodes look
    func look(forVoyage p: Voyage) -> Voyage? {
        var it = self.makeIterator()
        while let pers = it.next() {
            if (pers == p){
                return pers
            }
        }
        return nil
    }
    /*
    func look(forVoyageWithFirstName prenom: String) -> [Voyage] {
        var res : [Voyage] = []
        for p in self{
            if( p.firstName == prenom ){
                res.append(p)
            }
        }
        return res
    }
    
    func look(forVoyageWithLastName nom: String) -> [Voyage] {
        var res : [Voyage] = []
        for p in self{
            if( p.lastName == nom ){
                res.append(p)
            }
        }
        return res
    }
    
    func look(forVoyageWithFirstName prenom: String, andLastName nom: String) -> [Voyage] {
        var res : [Voyage] = []
        var it = self.makeIterator()
        while let Voyage = it.next(){
            if (Voyage.firstName == prenom) && (Voyage.lastName==nom){
                res.append(Voyage)
            }
        }
        return res
    }
    
    func look(forVoyageWithFirstName prenom: String, lastName nom: String, andBirthDate dateB: Date?) -> Voyage? {
        var it = self.makeIterator()
        while let Voyage = it.next(){
            if (Voyage.firstName == prenom) && (Voyage.lastName==nom) && (Voyage.birthDate == dateB){
                return Voyage
            }
        }
        return nil
    }*/
    
    
    
    //Les méthodes contains
    
    func contains(p: Voyage) -> Bool {
        return self.VoyageSet.contains(where: {$0==p})
    }
    /*
    func contains(VoyageWithFirstname prenom: String) -> Bool {
        return self.VoyageSet.contains(where: {$0.firstName==prenom})
    }
    
    func contains(VoyageWithLastname nom: String) -> Bool {
        return self.VoyageSet.contains(where: {$0.lastName==nom})
    }
    
    func contains(VoyageWithFirstname prenom: String, andLastName nom: String) -> Bool {
        return true
    }
    
    func contains(pSet: VoyageSet, prenom: String, nom: String, date:  Date?) -> Bool {
        return self.VoyageSet.contains(where: { ($0.firstName==prenom) && ($0.lastName==nom) })
    }
    */
    
    
    
    func indexOf(p: Voyage) -> Int? {
        guard self.count(pSet: self) > 0 else { return nil }
        var index : Int = 0
        var current : Voyage = self.VoyageSet[index]
        var found : Bool = (current == p)
        while ((index < self.count(pSet: self)) && !found){
            index += 1
            if (index < self.count(pSet: self)){
                current = self.VoyageSet[index]
                found = (current == p)
            }
        }
        return found ? index : nil
    }
    
    public func makeIterator() -> ItVoyageSet {
        return ItVoyageSet(set: self)
    }
    
}

struct ItVoyageSet :IteratorProtocol{
    private var index: Int = 0
    private var set: VoyageSet
    
    fileprivate init(set: VoyageSet){
        self.set = set
        self = self.reset()
    }
    
    public mutating func reset() -> ItVoyageSet {
        self.index = 0
        return self
        
    }
    
    public mutating func next() -> Voyage? {
        guard self.index < self.set.VoyageSet.count else{
            return nil
        }
        let nextVoyage = self.set.VoyageSet[self.index]
        self.index += 1
        return nextVoyage
    }
    
    func current() -> Voyage? {
        if !end {
            return self.set.VoyageSet[self.index]
        }
        return nil
    }
    
    public var end: Bool {
        return self.index < self.set.VoyageSet.count
    }
    
}
