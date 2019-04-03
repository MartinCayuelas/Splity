//
//  Participer.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 25/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Participer{
    // MARK: -
    /// date d'arrivée du voyageur dans le voyage
    public var dateArrivee : Date { return self.pDateArrivee! as Date }
    /// date de départ du voyageur dans le voyage
    public var dateDepart  : Date? { return self.pDateDepart as Date? }
    /// Voyage
    public var voyage : Voyage{
        get{ return self.pVoyage! }
        set{ self.pVoyage = newValue }
    }
    /// Voyageur
    public var voyageur : Voyageur {
        get { return self.pVoyageur!  }
        set { self.pVoyageur = newValue }
    }
    /// initialize a `Participer`
    ///
    /// - Parameters:
    ///   - dateArrivee: `Date` date d'arrivée du voyageur au voyage
    ///   - dateDepart:  `Date` date de départ du voyageur au voyage
    ///   - voyage: voyage concerné
    ///   - voyageur: voyageur concerné
    convenience init(dateArrivee: Date, dateDepart: Date?, voyage: Voyage, voyageur: Voyageur){
        self.init(context: CoreDataManager.context)
        self.pDateArrivee = dateArrivee as NSDate
        self.pDateDepart  = dateDepart as NSDate?
        self.pVoyage = voyage
        self.pVoyageur = voyageur
    }
}
