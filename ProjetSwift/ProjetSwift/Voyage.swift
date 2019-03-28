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
    public var actif : Bool { return self.pActif}
    
    public var dateDebut : Date { return self.pDateDebut! as Date}
    
    public var dateFin : Date? { return self.pDateFin as Date?}
    
    /// pour savoir si le voyage est archivé ou actif
    public var participants : [Participer] {
        get{
            if let p = self.pVoyageurs?.allObjects as? [Participer] {
                return p
            } else {
                return[]
            }
        }
    }
    /// liste des voyageurs du voyage
    public var depenses : [Depense] {
        get{
            if let d = self.pDepenses?.allObjects as? [Depense] {
                return d
            } else {
                return[]
            }
        }
    }
    /// liste des dépenses du voyage
    
    /// initialize a `Voyage`
    ///
    /// - Parameters:
    ///   - titre: `String` titre du voyage
    ///   - photo:  `String` photo du voyage
    convenience init(titre: String, photo: String){
        self.init(context: CoreDataManager.context)
        self.pTitreVoyage = titre
        self.pPhotoVoyage  = photo
        self.pActif = true
        self.pDateDebut = Date() as NSDate
        self.pDateFin = nil
    }
    
}
