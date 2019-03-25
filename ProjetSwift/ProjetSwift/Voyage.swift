//
//  Voyage.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 13/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Voyage {
    
    public var titre : String { return self.pTitreVoyage ?? "" }
    /// titre du voyage
    public var photo  : String { return self.pPhotoVoyage  ?? "" }
    /// image du voyage
    
    /// initialize a `Voyage`
    ///
    /// - Parameters:
    ///   - titre: `String` titre du voyage
    ///   - photo:  `String` photo du voyage
    convenience init(titre: String, photo: String){
        self.init(context: CoreDataManager.context)
        self.pTitreVoyage = titre
        self.pPhotoVoyage  = photo
    }
    
}
