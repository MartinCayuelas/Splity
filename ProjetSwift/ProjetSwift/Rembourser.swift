//
//  Rembourser.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 29/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation

extension Rembourser{
    // MARK: -
    /// montant remboursé
    public var montant : Double { return self.pMontantRembourse }
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
    /// initialize a `Rembourser`
    ///
    /// - Parameters:
    ///   - montant : montant remboursé
    ///   - depense: depense concernée
    ///   - voyageur: voyageur concerné
    convenience init(montant: Double, depense: Depense, voyageur: Voyageur){
        self.init(context: CoreDataManager.context)
        self.pMontantRembourse = montant
        self.pDepense = depense
        self.pVoyageur = voyageur
    }
}
