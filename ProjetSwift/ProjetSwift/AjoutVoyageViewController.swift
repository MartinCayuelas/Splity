//
//  AjoutVoyageViewController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 19/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit

class AjoutVoyageViewController: UIViewController {
    
    var controllerVoyageursTableView: AjoutVoyageurTableViewController!
    
    @IBOutlet weak var tableVoyageurs: UITableView!
    
    @IBOutlet weak var textFieldTitreVoyage: UITextField!
    var newVoyage : Voyage?
    
    var listVoyageurSelectionnes : [Voyageur] = []
    
    
    
    
    //Photos
    
    @IBOutlet weak var imageViewVoyage: UIImageView!
    @IBOutlet weak var cameraBouton: UIButton!
    @IBOutlet weak var parcourirBouton: UIButton!
    
    
    @IBAction func camera(_ sender: Any) {
         presentUIImagePicker(sourceType: .camera)
    }
    
    @IBAction func librairie(_ sender: Any) {
         presentUIImagePicker(sourceType: .photoLibrary)
    }
    
    // MARK: Helper MethodsPhotosCameras
    private func presentUIImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.controllerVoyageursTableView = AjoutVoyageurTableViewController(tableView: tableVoyageurs)
        self.imageViewVoyage.image = UIImage(named: "travel")
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    // Declenché lors de l'ajout d'un voyage
    // Ajoute une nouveau voyage
    // Parameters : segue 'UIStoryboardSegue'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "voyageAddedSegue" {
            let titreVoyage : String  = self.textFieldTitreVoyage.text!
            
            
            
            let voyageImage = self.imageViewVoyage.image
            let imageData = UIImagePNGRepresentation(voyageImage!)
            self.newVoyage  = Voyage(titre: titreVoyage, photo: imageData as! NSData)
            
            //Pour insérer les instances dans la table 'Participer'
            for v in self.listVoyageurSelectionnes {
                var participation = Participer(dateArrivee: Date(), dateDepart: nil, voyage: self.newVoyage!, voyageur: v)
            }
            
        }
        if segue.identifier == "voyageurAddedSegue" {
            guard let controller = segue.destination as? AjoutVoyageurViewController else { return }
            controller.pagePrecedente = "Voyage"
        }
    }
    
    @IBAction func unwindToAddVoyageView(segue: UIStoryboardSegue){
        if segue.identifier == "voyageurAddedSegue" {
            guard let controller = segue.source as? AjoutVoyageurViewController else { return }
            if let voyageur = controller.newVoyageur {
                self.controllerVoyageursTableView.voyageurs.add(voyageur: voyageur)
                CoreDataManager.save()
              //  self.controllerVoyageursTableView.voyageurs = VoyageurSetViewModel(data: self.controllerVoyageursTableView.fetchResultController.voyageursFetched)
            }
            
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
    
    
    @IBAction func ajoutVoyageurToVoyage(_ sender: ButtonCheckBox) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableVoyageurs)
        if let indexPath = self.tableVoyageurs.indexPathForRow(at: buttonPosition){
            let voyageurCoche = self.controllerVoyageursTableView.voyageurs.get(voyageurAt: indexPath.row)
            
            if self.listVoyageurSelectionnes.contains(voyageurCoche!){ // Si deja dans le tableau
                let index = self.listVoyageurSelectionnes.firstIndex(of: voyageurCoche!)
                
                self.listVoyageurSelectionnes.remove(at: index!)
            }else{// Ajout dans le tableau
                
                self.listVoyageurSelectionnes.append(voyageurCoche!)
            }
        }
        
    }
    
    
    
}

// MARK: UIImagePickerControllerDelegate and UINavigationControllerDelegate
extension AjoutVoyageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        self.imageViewVoyage.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
