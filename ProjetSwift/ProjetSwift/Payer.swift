//
//  Payer.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 29/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Payer{
    // MARK: -
    /// montant payé
    public var montant : Double { return self.pMontantPaye }
    /// Dépense
    public var depense : Depense{
        get{ return self.pDepense! }
        set{ self.pDepense = newValue }
    }
    /// Voyageur
    public var voyageur : Voyageur {
        get { return self.pVoyageur!  }
        set { self.pVoyageur = newValue }
    }
    /// initialize a `Payer`
    ///
    /// - Parameters:
    ///   - montant : montant payé
    ///   - depense: depense concernée
    ///   - voyageur: voyageur concerné
    convenience init(montant: Double, depense: Depense, voyageur: Voyageur){
        self.init(context: CoreDataManager.context)
        self.pMontantPaye = montant
        self.pDepense = depense
        self.pVoyageur = voyageur
    }
}
