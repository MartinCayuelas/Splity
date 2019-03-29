//
//  DetailVoyageController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 18/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DetailVoyageViewController: UIViewController{
    
    @IBOutlet weak var imageVoyage: UIImageView!
    @IBOutlet weak var titreVoyage: UILabel!
    @IBOutlet weak var labelDateVoyage: UILabel!
    
    var voyageSelected : Voyage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let avoyage = self.voyageSelected {
            self.titreVoyage
                .text = avoyage.titre
            
            let photoVoyage = UIImage(data: avoyage.photo as! Data)
          
            
         self.imageVoyage.image =  photoVoyage
            
            let df = DateFormatter()
            df.locale = Locale(identifier: "fr_FR")
            df.dateFormat = "dd/MM/yyyy"
            let stringDate = df.string(from: avoyage.dateDebut)
           
            
            if(avoyage.dateFin == nil){
                
                self.labelDateVoyage.text = "Commencé le \(stringDate)"
            }else{
                let df2 = DateFormatter()
                df2.locale = Locale(identifier: "fr_FR")
                df2.dateFormat = "dd/MM/yyyy"
                let stringDate2 = df2.string(from: avoyage.dateFin!)
                self.labelDateVoyage.text = "Du \(stringDate) au \(stringDate2)"
            }
            
            
            
        } else {
            self.titreVoyage.text = ""
           
        }
        
    }
    
    //Pour donner le voyage sélectionné à la page suivante (liste des dépenses)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? DepensesViewController {
            destController.voyageSelected = self.voyageSelected
        }
        if let destController = segue.destination as? GestionVoyageursViewController {
            destController.voyageSelected = self.voyageSelected
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
