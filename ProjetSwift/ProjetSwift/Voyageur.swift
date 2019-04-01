//
//  Voyageur.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Voyageur {
    
    public var prenom : String { return self.pPrenom ?? "" }
    /// prénom du voyageur
    public var nom  : String { return self.pNom  ?? "" }
    /// nom du voyageur
    
    ///Booleen pour savoir si le voyageur est Actif ou non
    public var archive  : Bool { return self.pArchive}
    
    public var nomComplet: String {
        return self.prenom + " " + self.nom
    }
    /// nom complet du voyageur
    public var participations : [Participer] {
        get{
            if let p = self.pVoyages?.allObjects as? [Participer] {
                return p
            } else {
                return[]
            }
        }
    }
    /// liste des voyageurs du voyage

    
    /// liste des paiements
    public var paiements : [Payer] {
        get{
            if let p = self.pPaiements?.allObjects as? [Payer] {
                return p
            } else {
                return[]
            }
        }
    }
    
    /// liste des remboursements
    public var remboursements : [Rembourser] {
        get{
            if let p = self.pRemboursements?.allObjects as? [Rembourser] {
                return p
            } else {
                return[]
            }
        }
    }
    
    
    
    
    
    /// initialize a `Voyageur`
    ///
    /// - Parameters:
    ///   - prenom: `String` prénom du voyageur
    ///   - nom:  `String` nom du voyageur
    convenience init(nom: String, prenom: String){
        self.init(context: CoreDataManager.context)
        self.pPrenom = prenom
        self.pNom  = nom
        self.pArchive = false
    }
    
}
