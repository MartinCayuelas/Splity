//
//  Depense.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 26/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Depense {
    /// titre de la depense
    public var titre : String { return self.pTitreDepense ?? "" }
     /// image de la depense
    public var photo  : NSData { return self.pPhotoDepense! }
    /// date de la depense
    public var date : Date { return self.pDateDepense! as Date}
     ///montant de la depense
    public var montant  : Double { return self.pMontantDepense  }
    /// voyage de la dépense
    public var voyage : Voyage {
        get { return self.pVoyage!  }
        set { self.pVoyage = newValue }
    }
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
    
  
    
    
    /// initialize a `Voyage`
    ///
    /// - Parameters:
    ///   - titre: `String` titre du voyage
    ///   - photo:  `String` photo du voyage
    convenience init(titre: String, photo: NSData, date: Date, voyage: Voyage){
        self.init(context: CoreDataManager.context)
        self.pTitreDepense = titre
        self.pPhotoDepense  = photo
        self.pDateDepense = date as NSDate
        self.pVoyage = voyage
    }
    
    convenience init(titre: String, photo: NSData, date: Date){
        self.init(context: CoreDataManager.context)
        self.pTitreDepense = titre
        self.pPhotoDepense  = photo
        self.pDateDepense = date as NSDate
    }
    
}
