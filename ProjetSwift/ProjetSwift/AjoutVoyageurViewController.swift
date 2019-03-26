//
//  AjoutVoyageurViewController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 20/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutVoyageurViewController: UIViewController {
    @IBOutlet weak var boutonValiderDepuisAccueil: UIButton!
    @IBOutlet weak var boutonAnnulerDepuisVoyage: UIButton!
    @IBOutlet weak var boutonValiderDepuisVoyage: UIButton!
    @IBOutlet weak var boutonAnnulerDepuisAccueil: UIButton!
    
    @IBOutlet weak var textFieldNom: UITextField!
    @IBOutlet weak var textFieldPrenom: UITextField!
    var newVoyageur: Voyageur?
    var pagePrecedente: String = ""
    
    @IBOutlet weak var validateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(pagePrecedente == "Voyage"){
            self.boutonValiderDepuisAccueil.isHidden = true
            self.boutonAnnulerDepuisAccueil.isHidden = true
        }else{
            self.boutonAnnulerDepuisVoyage.isHidden = true
            self.boutonValiderDepuisVoyage.isHidden = true
        }
        
       
    }

    // Declenché lors de l'ajout d'un voyageur
    // Ajoute une nouveau voyageur
    // Parameters : segue 'UIStoryboardSegue'

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "voyageurAddedSegue" {
            let prenomVoyageur : String  = self.textFieldPrenom.text!
            let nomVoyageur : String  = self.textFieldNom.text!
            self.newVoyageur  = Voyageur(nom: nomVoyageur, prenom: prenomVoyageur)
        }
    }
    
}
