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
    
    /// Initialise un voyageSet Vide
    ///
    ///
    init(){
        self.VoyageSet = []
    }
    
    /// Initialise un voyageSet
    ///
    /// - Parameter Voyages: un tableau de voyages
    ///
    init(Voyages: [Voyage]) {
        for v in Voyages {
            self.VoyageSet.append(v)
        }
    }
    
    /// Compte le nombre d'élément dans le voyageSet
    ///
    /// 

    var count : Int {
        return self.VoyageSet.count
    }
    
     /// Verifie si le voyageSet est vide
    ///
    /// - Parameter vSet: un voyageSet
    /// - return un booleen: vrai si vide, faux sinon
    
    func isEmpty(vSet: VoyageSet) -> Bool {
        return isEmpty(vSet: vSet)
    }
    
    /// Ajoute un voyage au voyageSet
    ///
    /// - Parameter:  v: un voyage
    /// - returns : le voyageSet avec le voyage ajoute
    func add(v: Voyage) -> VoyageSet {
        if !self.VoyageSet.contains(v){
            self.VoyageSet.append(v)
        }
        return self
    }

      /// Supprime un voyage au voyageSet
    ///
    /// - Parameter:  v: un voyage
    /// - returns : le voyageSet avec le voyage supprime
    
    
    func remove(v: Voyage) -> VoyageSet {
        if let i = self.VoyageSet.index(of: v) {
            self.VoyageSet.remove(at: i)
        }
        return self
    }

    /// Compte le nombre de voyages contenu dans le voyageSet
    ///
    /// - Parameter:  vSet: un voyageSet
    /// - returns : un entier correspondand au nombre d'éléments contenus 
    
    func count(vSet: VoyageSet) -> Int {
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
    
    func contains(v: Voyage) -> Bool {
        return self.VoyageSet.contains(where: {$0==v})
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
    
    
    
    func indexOf(v: Voyage) -> Int? {
        guard self.count(vSet: self) > 0 else { return nil }
        var index : Int = 0
        var current : Voyage = self.VoyageSet[index]
        var found : Bool = (current == v)
        while ((index < self.count(vSet: self)) && !found){
            index += 1
            if (index < self.count(vSet: self)){
                current = self.VoyageSet[index]
                found = (current == v)
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
