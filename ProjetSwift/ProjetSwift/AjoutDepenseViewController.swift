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
    
    @IBOutlet weak var imageDepenseView: UIImageView!
    @IBOutlet weak var librairieBouton: UIButton!
    @IBOutlet weak var cameraBouton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
            self.newDepense  = Depense(titre: titreDepense, photo: imageData as! NSData, date: dateDepense, voyage: self.voyageSelected!)
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
