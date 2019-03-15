//
//  Voyage.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

class Voyage {
    var titre: String
    var image: String
    
    init(titre : String, image: String) {
        self.titre = titre
        self.image = image
    }
    
}

extension Voyage : Equatable {
    
    static func == (v1 : Voyage, v2 : Voyage) -> Bool {
        return v1.titre == v2.titre
    }
    
    static func != (v1 : Voyage, v2 : Voyage) -> Bool {
        return !(v1 == v2)
    }
    
}
