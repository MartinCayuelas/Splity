//
//  AjoutDepenseViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 22/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutDepenseViewController : UIViewController {
    
    @IBOutlet weak var titreDepenseTextField: UITextField!
    var newDepense: Depense?
    var voyageSelected: Voyage?
    
    var listePayeurs : [Voyageur] = []
    var listePayeursMontant : [Double] = []
    var listeRembourseurs : [Voyageur] = []
    var listeRembourseursMontant : [Double] = []
    
     var controllerVoyageursPayeursTableView: AjoutDepensePayeurTableViewController!
    var controllerVoyageursRembourseursTableView : AjoutDepenseRembourseurTableViewController!
    
    @IBOutlet weak var imageDepenseView: UIImageView!
    @IBOutlet weak var librairieBouton: UIButton!
    @IBOutlet weak var cameraBouton: UIButton!
    
    @IBOutlet weak var tableviewPayeurs: UITableView!
    @IBOutlet weak var tableviewRembourseurs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.controllerVoyageursPayeursTableView = AjoutDepensePayeurTableViewController(tableView: tableviewPayeurs, voyageSelected: self.voyageSelected!)
        self.controllerVoyageursRembourseursTableView = AjoutDepenseRembourseurTableViewController(tableView: tableviewRembourseurs,voyageSelected: self.voyageSelected!)
        
        self.imageDepenseView.image = UIImage(named: "money") 
    }
    
    
    @IBAction func librairie(_ sender: Any) {
         presentUIImagePicker(sourceType: .photoLibrary)
    }
    
    @IBAction func camera(_ sender: Any) {
         presentUIImagePicker(sourceType: .camera)
    }
    
    //Photos
    // MARK: Helper MethodsPhotosCameras
    private func presentUIImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }

    // Declenché lors de l'ajout d'une depense
    // Ajoute une nouvelle depense
    // Parameters : segue 'UIStoryboardSegue'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "depenseAddedSegue" {
            let titreDepense : String  = self.titreDepenseTextField.text!
            let dateDepense : Date = Date()
            
            let depImage = self.imageDepenseView.image
            let imageData = UIImagePNGRepresentation(depImage!)
            
            //Ajout dans la table 'Depense' sans montant pour le moment
            self.newDepense  = DepenseDAO.ajouterDepense(fortitre: titreDepense, andPhoto: imageData! as NSData, andDate: dateDepense, andVoyage: self.voyageSelected!)
            
            //Récupération du montant payé par chaque payeur
            for case let cell as AjoutDepensePayeurCell in self.tableviewPayeurs.visibleCells {
                if(cell.checkButton.isChecked == true){
                    
                    let voyageurCoche = self.controllerVoyageursPayeursTableView.voyageurs.get(voyageurAt: (cell.indexPath?.row)!)
                    self.listePayeurs.append(voyageurCoche!)
                    let montant = cell.montantDepense.text!
                    self.listePayeursMontant.append(Double(montant)!)
                }
            }
            
            //Récupération du montant remboursé par chaque rembourseur
            for case let cell as AjoutDepenseRembourseurCell in self.tableviewRembourseurs.visibleCells {
               
                if(cell.checkButton.isChecked == true){
                    let voyageurCoche = self.controllerVoyageursRembourseursTableView.voyageurs.get(voyageurAt: (cell.indexPath?.row)!)
                 
                    self.listeRembourseurs.append(voyageurCoche!)
                    let montant = cell.montantDepense.text!
                    self.listeRembourseursMontant.append(Double(montant)!)
                }
            }
            
            //Ajout des paiements dans la table 'Payer'
            var totalPaiements: Double = 0
            for p in self.listePayeurs {
                let index = self.listePayeurs.firstIndex(of: p)
                let montant = self.listePayeursMontant[index!]
                
                DepenseDAO.ajouterPaiement(forDepense: self.newDepense!, andVoyageur: p, andMontant: montant)
                totalPaiements = totalPaiements + montant
            }
            
            //Ajout des remboursements dans la table 'Rembourser'
            var totalRemboursements: Double = 0
            for r in self.listeRembourseurs {
                let index = self.listeRembourseurs.firstIndex(of: r)
                let montant = self.listeRembourseursMontant[index!]
               
                DepenseDAO.ajouterRemboursement(forDepense: self.newDepense!, andVoyageur: r, andMontant: montant)
                totalRemboursements = totalRemboursements + montant
            }
            
            //Ajout du montant de la dépense
            DepenseDAO.insererMontantDepense(forDepense: self.newDepense!)
        }
    }
}

// MARK: UIImagePickerControllerDelegate and UINavigationControllerDelegate
extension AjoutDepenseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        self.imageDepenseView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
