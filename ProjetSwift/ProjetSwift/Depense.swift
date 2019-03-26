//
//  Depense.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 26/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Depense {
    
    public var titre : String { return self.pTitreDepense ?? "" }
    /// titre du voyage
    public var photo  : String? { return self.pPhotoDepense  ?? "" }
    /// image du voyage
    public var date : Date { return self.pDateDepense! as Date}
    
    /// initialize a `Voyage`
    ///
    /// - Parameters:
    ///   - titre: `String` titre du voyage
    ///   - photo:  `String` photo du voyage
    convenience init(titre: String, photo: String, date: Date){
        self.init(context: CoreDataManager.context)
        self.pTitreDepense = titre
        self.pPhotoDepense  = photo
        self.pDateDepense = date as NSDate
    }
    
}
