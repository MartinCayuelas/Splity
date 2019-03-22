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
    public var nomComplet: String {
        return self.prenom + " " + self.nom
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
    }
    
}
