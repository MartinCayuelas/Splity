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
    
    var montantParPersonne : Double = 0
    var montantARembourser : Double = 0
    
    var listeRembourseursPotentiels : [Voyageur] = []
    
     var controllerVoyageursPayeursTableView: AjoutDepensePayeurTableViewController!
    var controllerVoyageursRembourseursTableView : AjoutDepenseRembourseurTableViewController!
    
    @IBOutlet weak var imageDepenseView: UIImageView!
    @IBOutlet weak var librairieBouton: UIButton!
    @IBOutlet weak var cameraBouton: UIButton!
    @IBOutlet weak var boutonValider: UIButton!
    
    @IBOutlet weak var tableviewPayeurs: UITableView!
    @IBOutlet weak var tableviewRembourseurs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Cacher le bouton valider au départ
        self.boutonValider.isHidden = true
        
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
            if let destController = segue.destination as? DepensesViewController {
                let titreDepense : String  = self.titreDepenseTextField.text!
                let dateDepense : Date = Date()
                
                let depImage = self.imageDepenseView.image
                let imageData = UIImagePNGRepresentation(depImage!)
                
                //Récupération du montant payé par chaque payeur
                for case let cell as AjoutDepensePayeurCell in self.tableviewPayeurs.visibleCells {
                    if(cell.checkButton.isChecked == true){
                        
                        let voyageurCoche = self.controllerVoyageursPayeursTableView.voyageurs.get(voyageurAt: (cell.indexPath?.row)!)
                        self.listePayeurs.append(voyageurCoche!)
                        var montant = cell.montantDepense.text!
                        if(montant == "") {
                            montant = "0"
                        }
                        self.listePayeursMontant.append(Double(montant)!)

                    }
                }
                
                //Récupération du montant remboursé par chaque rembourseur
                for case let cell as AjoutDepenseRembourseurCell in self.tableviewRembourseurs.visibleCells {
                    
                    if(cell.checkButton.isChecked == true){
                        let voyageurCoche = self.controllerVoyageursRembourseursTableView.voyageurs.get(voyageurAt: (cell.indexPath?.row)!)
                        
                        self.listeRembourseurs.append(voyageurCoche!)
                        var montant = cell.montantDepense.text!
                        if(montant == "") {
                            montant = "0"
                        }
                        self.listeRembourseursMontant.append(Double(montant)!)
                        
                    }
                }
                
                //Deuxième test pour les montants égaux
                //Si les montants ne sont pas égaux
                if(getTotalPaiements() - getTotalRemboursements() >= 0.01 || getTotalPaiements() - getTotalRemboursements() <= -0.01) {
                    
                    //Interdire l'ajout de la dépense
                    destController.depenseImpossible = true
                    
                } else {
                    //Autoriser l'ajout de la dépense
                    destController.depenseImpossible = false
                    
                    //Ajout dans la table 'Depense' sans montant pour le moment
                    self.newDepense  = DepenseDAO.ajouterDepense(fortitre: titreDepense, andPhoto: imageData! as NSData, andDate: dateDepense, andVoyage: self.voyageSelected!)
                    
                    //Ajout des paiements dans la table 'Payer'
                    for p in self.listePayeurs {
                        let index = self.listePayeurs.firstIndex(of: p)
                        let montant = self.listePayeursMontant[index!]
                        
                        DepenseDAO.ajouterPaiement(forDepense: self.newDepense!, andVoyageur: p, andMontant: montant)
                    }
                    
                    //Ajout des remboursements dans la table 'Rembourser'
                    for r in self.listeRembourseurs {
                        let index = self.listeRembourseurs.firstIndex(of: r)
                        let montant = self.listeRembourseursMontant[index!]
                        
                        DepenseDAO.ajouterRemboursement(forDepense: self.newDepense!, andVoyageur: r, andMontant: montant)
                    }
                    
                    //Ajout du montant de la dépense
                    DepenseDAO.insererMontantDepense(forDepense: self.newDepense!)
                }
            }
            
        }
    }
    
    
    func setMontantADiviser(){
        self.montantARembourser = 0
        //Récupération du montant payé par chaque payeur
        for case let cell as AjoutDepensePayeurCell in self.tableviewPayeurs.visibleCells {
            if(cell.checkButton.isChecked == true){
                if (cell.montantDepense.text?.isEmpty)!{
                }else {
                    self.montantARembourser = self.montantARembourser + Double(cell.montantDepense.text!)!
                }
                
            }
        }
        self.getRembourseurs()
        self.calculMontantParPersonne(forMotantTotalPaye: self.montantARembourser)
        
        
    }
    
    
    @IBAction func ajoutRemourseurToListe(_ sender: ButtonCheckBox) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableviewRembourseurs)
        if let indexPath = self.tableviewRembourseurs.indexPathForRow(at: buttonPosition){
            let v : Voyageur = self.controllerVoyageursRembourseursTableView.voyageurs.get(voyageurAt: indexPath.row)!
            
            if self.listeRembourseursPotentiels.contains(v){ // Si deja dans le tableau
                let index = self.listeRembourseursPotentiels.firstIndex(of: v)
                
                self.listeRembourseursPotentiels.remove(at: index!)
            }else{// Ajout dans le tableau
                
                self.listeRembourseursPotentiels.append(v)
            }
        }
    }
    
    
    func getRembourseurs(){
        //Vider la liste des rembourseurs
        self.listeRembourseursPotentiels.removeAll()
        
        //Récupération du montant remboursé par chaque rembourseur
        for case let cell as AjoutDepenseRembourseurCell in self.tableviewRembourseurs.visibleCells {
            
            if(cell.checkButton.isChecked == true){
                let voyageurCoche = self.controllerVoyageursRembourseursTableView.voyageurs.get(voyageurAt: (cell.indexPath?.row)!)
                
                //On ajoute le voyageur dans la liste
                self.listeRembourseursPotentiels.append(voyageurCoche!)
               
            }
        }
    }
    
    func calculMontantParPersonne(forMotantTotalPaye montant: Double){
        self.montantParPersonne =  montant / Double(self.listeRembourseursPotentiels.count)
    }
    
    func remplissageRembourseur(){
        
        //Récupération du montant remboursé par chaque rembourseur
        for case let cell as AjoutDepenseRembourseurCell in self.tableviewRembourseurs.visibleCells {
            
            if(cell.checkButton.isChecked == true){
            
                cell.montantDepense.text = "\(self.montantParPersonne)"
            } else {
                cell.montantDepense.text = ""
            }
        }
    }
    
    //Récupération du total des paiements de la dépense
    private func getTotalPaiements() -> Double {
        //Récupération du montant payé par chaque payeur
        var total: Double = 0
        for case let cell as AjoutDepensePayeurCell in self.tableviewPayeurs.visibleCells {
            if(cell.checkButton.isChecked == true){
                var montant : String = "0"
                if(cell.montantDepense.text! != ""){
                    montant = cell.montantDepense.text!
                }
                total = total + Double(montant)!
            }
        }
        return total
    }
    
    //Récupération du total des remboursements de la dépense
    private func getTotalRemboursements() -> Double {
        //Récupération du montant remboursé par chaque payeur
        var total: Double = 0
        for case let cell as AjoutDepenseRembourseurCell in self.tableviewRembourseurs.visibleCells {
            if(cell.checkButton.isChecked == true){
                var montant : String = "0"
                if(cell.montantDepense.text! != ""){
                    montant = cell.montantDepense.text!
                }
                total = total + Double(montant)!
            }
        }
        return total
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //Cas du qui paie
        if(textField.accessibilityIdentifier == "quiPaieTextField"){
            self.setMontantADiviser()
            self.remplissageRembourseur()
        } else {
            //Cas du pour qui
        }
        
        let totalPaiement: Double = self.getTotalPaiements()
        let totalRemboursement: Double = self.getTotalRemboursements()
        
        //Si les montants de paiements et remboursements ne sont pas égaux
        if(totalPaiement - totalRemboursement >= 0.01 || totalPaiement - totalRemboursement <= -0.01) {
            self.boutonValider.isHidden = true
        }
        //Si ils sont égaux
        else {
            self.boutonValider.isHidden = false
        }
        
        return true
        
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
