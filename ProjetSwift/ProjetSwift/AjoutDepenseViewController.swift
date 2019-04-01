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
            self.newDepense  = DepenseDAO.ajouterDepense(fortitre: titreDepense, andPhoto: imageData! as NSData, andDate: dateDepense, andVoyage: self.voyageSelected!)
            
            
            
            for p in self.listePayeurs {
                let index = self.listePayeurs.firstIndex(of: p)
                let montant = self.listePayeursMontant[index!]
                
                DepenseDAO.ajouterPaiement(forDepense: self.newDepense!, andVoyageur: p, andMontant: montant)
                
                
            }
            
            for r in self.listeRembourseurs {
                let index = self.listeRembourseurs.firstIndex(of: r)
                let montant = self.listeRembourseursMontant[index!]
               
                DepenseDAO.ajouterRemboursement(forDepense: self.newDepense!, andVoyageur: r, andMontant: montant)
                
                
                
            }
            
            DepenseDAO.insererMontantDepense(forDepense: self.newDepense!)
            
            
            
        }
    }
    
    @IBAction func ajoutPayeurToDepense(_ sender: ButtonCheckBox) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableviewPayeurs)
        
        
        if let indexPath = self.tableviewPayeurs.indexPathForRow(at: buttonPosition){
            let voyageurCoche = self.controllerVoyageursPayeursTableView.voyageurs.get(voyageurAt: indexPath.row)
            
            let cell =
                self.controllerVoyageursPayeursTableView.tableView.cellForRow(at: indexPath) as! AjoutDepensePayeurCell
        
            var montant = cell.montantDepense.text!
            
            if self.listePayeurs.contains(voyageurCoche!){ // Si deja dans le tableau
                let index = self.listePayeurs.firstIndex(of: voyageurCoche!)
                self.listePayeursMontant.remove(at: index!)
                
                self.listePayeurs.remove(at: index!)
            }else{// Ajout dans le tableau
                
                self.listePayeurs.append(voyageurCoche!)
                self.listePayeursMontant.append(Double(montant) ?? 0)
            }
        }
        
    }
        
    @IBAction func ajouterRembourseurToDepense(_ sender: ButtonCheckBox) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableviewRembourseurs)
        if let indexPath = self.tableviewRembourseurs.indexPathForRow(at: buttonPosition){
            let voyageurCoche = self.controllerVoyageursRembourseursTableView.voyageurs.get(voyageurAt: indexPath.row)
            
            let cell =
                self.controllerVoyageursRembourseursTableView.tableView.cellForRow(at: indexPath) as! AjoutDepenseRembourseurCell
            
            var montant = cell.montantDepense.text!
            
            
            if self.listeRembourseurs.contains(voyageurCoche!){ // Si deja dans le tableau
                let index = self.listeRembourseurs.firstIndex(of: voyageurCoche!)
                self.listeRembourseursMontant.remove(at: index!)
                self.listeRembourseurs.remove(at: index!)
            }else{// Ajout dans le tableau
                
                self.listeRembourseurs.append(voyageurCoche!)
                 self.listeRembourseursMontant.append(Double(montant) ?? 0)
            }
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
