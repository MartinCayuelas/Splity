//
//  VoyageurSet.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 20/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class VoyageurSet: Sequence {

    fileprivate var voyageurSet : [Voyageur] = []
    
    /// Initialise un voyageurSet Vide
    ///
    ///
    init(){
        self.voyageurSet = []
    }
    
    /// Initialise un voyageurSet
    ///
    /// - Parameter voyageurs: un tableau de voyageurs
    ///
    init(voyageurs: [Voyageur]) {
        for v in voyageurs {
            self.voyageurSet.append(v)
        }
    }
    
    /// Compte le nombre d'élément dans le voyageurSet
    ///
    /// 
    var count : Int {
        return self.voyageurSet.count
    }
    
    /// Verifie si le voyageurSet est vide
    ///
    /// -
    /// -
    func isEmpty() -> Bool {
        return self.voyageurSet.isEmpty
    }

     /// Ajoute un voyage au voyageurSet
    ///
    /// - Parameter:  v: un voyageur
    /// - returns : le voyageurSet avec le voyageur ajoute
    
    @discardableResult
    func add(v: Voyageur) -> VoyageurSet {
        if !self.voyageurSet.contains(v){
            self.voyageurSet.append(v)
        }
        return self
    }
    
    /// Supprime un voyageur au voyageurSet
    ///
    /// - Parameter:  v: un voyageur
    /// - returns : le voyageurSet avec le voyageur supprime
    
    @discardableResult
    func remove(v: Voyageur) -> VoyageurSet {
        if let i = self.voyageurSet.index(of: v) {
            self.voyageurSet.remove(at: i)
        }
        return self
    }

    
    /// Compte le nombre de voyageurs contenu dans le voyageurSet
    ///
    /// - Parameter:  vSet: un voyageurSet
    /// - returns : un entier correspondand au nombre d'éléments contenus 
    
    
    func count(pSet: VoyageurSet) -> Int {
        return self.voyageurSet.count
    }
    
    //Les méthodes look
    func look(forVoyageur v: Voyageur) -> Voyageur? {
        var it = self.makeIterator()
        while let voyageur = it.next() {
            if (voyageur == v){
                return voyageur
            }
        }
        return nil
    }
    
    func look(forVoyageurWithPrenom prenom: String) -> [Voyageur] {
        var res : [Voyageur] = []
        for v in self{
            if(v.prenom == prenom){
                res.append(v)
            }
        }
        return res
    }
    
    func look(forVoyageurWithNom nom: String) -> [Voyageur] {
        var res : [Voyageur] = []
        for v in self{
            if(v.nom == nom){
                res.append(v)
            }
        }
        return res
    }
    
    func look(forVoyageurWithPrenom prenom: String, andNom nom: String) -> [Voyageur] {
        var res : [Voyageur] = []
        var it = self.makeIterator()
        while let voyageur = it.next(){
            if (voyageur.prenom == prenom) && (voyageur.nom==nom){
                res.append(voyageur)
            }
        }
        return res
    }
    
    
    
    //Les méthodes contains
    
    func contains(v: Voyageur) -> Bool {
        return self.voyageurSet.contains(where: {$0==v})
    }
    
    func contains(voyageurWithPrenom prenom: String) -> Bool {
        return self.voyageurSet.contains(where: {$0.prenom==prenom})
    }
    
    func contains(voyageurWithNom nom: String) -> Bool {
        return self.voyageurSet.contains(where: {$0.nom==nom})
    }
    
    func contains(voyageurWithPrenom prenom: String, andNom nom: String) -> Bool {
        return true
    }
    
    
    
    func indexOf(v: Voyageur) -> Int? {
        guard self.count > 0 else { return nil }
        var index : Int = 0
        var current : Voyageur = self.voyageurSet[index]
        var found : Bool = (current == v)
        while ((index < self.count) && !found){
            index += 1
            if (index < self.count){
                current = self.voyageurSet[index]
                found = (current == v)
            }
        }
        return found ? index : nil
    }
    
    public func makeIterator() -> ItVoyageurSet {
        return ItVoyageurSet(set: self)
    }
    
    
    subscript(index: Int) -> Voyageur {
        get {
            guard (index>=0) && (index<self.count) else{
                fatalError("index out of range")
            }
            return self.voyageurSet[index]
        }
        set(newValue) {
            guard (index>=0) && (index<self.count) else{
                fatalError("index out of range")
            }
            self.voyageurSet[index]=newValue
        }
    }
    
    
}

struct ItVoyageurSet :IteratorProtocol{
    private var index: Int = 0
    private var set: VoyageurSet
    
    fileprivate init(set: VoyageurSet){
        self.set = set
        self = self.reset()
    }
    
    public mutating func reset() -> ItVoyageurSet {
        self.index = 0
        return self
        
    }
    
    public mutating func next() -> Voyageur? {
        guard self.index < self.set.voyageurSet.count else{
            return nil
        }
        let nextPerson = self.set.voyageurSet[self.index]
        self.index += 1
        return nextPerson
    }
    
    func current() -> Voyageur? {
        if !end {
            return self.set.voyageurSet[self.index]
        }
        return nil
    }
    
    public var end: Bool {
        return self.index < self.set.voyageurSet.count
    }
    
}
