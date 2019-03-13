//
//  Voyageur.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

class Voyageur {
    var nom: String
    var prenom: String
    var nomComplet: String {
        return self.prenom + " " + self.nom
    }
    
    init(nom : String, prenom : String) {
        self.prenom = prenom
        self.nom = nom
    }
  
}

extension Voyageur : Equatable {
    
    static func == (lhs : Voyageur, rhs : Voyageur) -> Bool {
        return lhs.prenom == rhs.prenom && lhs.nom == rhs.nom
    }
    
    static func != (lhs : Voyageur, rhs : Voyageur) -> Bool {
        return !(lhs == rhs)
    }
    
}
