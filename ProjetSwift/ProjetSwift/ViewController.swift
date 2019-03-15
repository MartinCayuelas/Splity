//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 11/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func validate(_ sender: Any) {
        validateButton.backgroundColor = UIColor.orange
       /* if (textFieldContent.text?.isEmpty)! || (saisiePrenom.text?.isEmpty)! {
            validateButton.isEnabled = false
        }else{
            validateButton.isEnabled = true
        }*/
        /*if let nom = self.textFieldContent.text {
            if !nom.isEmpty {
                self.titleLabel.text = nom
            }
        }else{*/
            self.titleLabel.text = "Splity"
        /*}*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? VoyagesTableViewController {
            destController.nomVoyageur = self.textFieldContent.text!
            destController.prenomVoyageur = self.saisiePrenom.text!
        }
    }
    
    @IBOutlet weak var textFieldContent: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var saisiePrenom: UITextField!
}

