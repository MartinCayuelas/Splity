//
//  Voyageur.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

class Voyageur {
    var lastName: String
    var firstName: String
    var fullName: String {
        return self.firstName + " " + self.lastName
    }
    
    init(lastName : String, firstName : String) {
        self.firstName = firstName
        self.lastName = lastName
    }
  
}

extension Voyageur : Equatable {
    
    static func == (lhs : Voyageur, rhs : Voyageur) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    static func != (lhs : Voyageur, rhs : Voyageur) -> Bool {
        return !(lhs == rhs)
    }
    
}
