//
//  Depense.swift
//  ProjetSwift
//
//  Created by Nathan Guillaud on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

class Depense {
    var titre: String
    var montant: Double
    var image: String?
    
    init(titre : String, montant : Double, image: String?) {
        self.titre = titre
        self.montant = montant
        self.image = image
    }
    
}

extension Depense : Equatable {
    
    static func == (d1 : Depense, d2 : Depense) -> Bool {
        return d1.titre == d2.titre
    }
    
    static func != (d1 : Depense, d2 : Depense) -> Bool {
        return !(d1 == d2)
    }
    
}
