//
//  DetailDepenseViewController.swift
//  ProjetSwift
//
//  Created by Martin CAYUELAS on 29/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class DetailDepenseViewController : UIViewController {


    var depenseCourante : Depense?
    var payeurs : [Voyageur] = []
    
    @IBOutlet weak var imageViewDepense: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var montantLabel: UILabel!
    @IBOutlet weak var textViewListePayeurs: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let adepense = self.depenseCourante {
            self.montantLabel
                .text = "\(adepense.montant) €"
            
            let photoDep = UIImage(data: adepense.photo as! Data)
            
            
            self.imageViewDepense.image =  photoDep
            
            let df = DateFormatter()
            df.locale = Locale(identifier: "fr_FR")
            df.dateFormat = "dd/MM/yyyy"
            let stringDate = df.string(from: adepense.date)
            
            self.dateLabel.text = stringDate
            
            self.payeurs = DepenseDAO.getPayeursDepense(forDepense: self.depenseCourante!)
            var payeursStr = ""
            for p in payeurs{
                
                let montant = DepenseDAO.getMontant(forDepense: self.depenseCourante!, andPayeur: p)
                payeursStr += "- \(p.nomComplet) :  \(montant) € \n"
            }
            self.textViewListePayeurs.text = payeursStr
            
            
        }
        
    }
    
}

