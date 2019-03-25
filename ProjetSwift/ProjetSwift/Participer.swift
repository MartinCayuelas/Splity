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
    public var dateArrivee : Date { return self.pDateArrivee as! Date }
    /// date de départ du voyageur dans le voyage
    public var dateDepart  : Date? { return self.pDateDepart as! Date }
    
    public var voyage : String{
        get{ return self.pVoyage?.pTitreVoyage ?? "" }
    }
    public var voyageur : String {
        get { return (self.pVoyageur?.pPrenom)! + " " + (self.pVoyageur?.pNom)! }
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
        self.pDateDepart  = dateDepart as! NSDate
        self.pVoyage = voyage
        self.pVoyageur = voyageur
    }
}
