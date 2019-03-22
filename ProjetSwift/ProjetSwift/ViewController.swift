//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 11/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet var controllerVoyageursTableView: VoyageursTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? VoyagesViewController {
            if let cell = sender as? UITableViewCell {
                guard let indexPath = self.controllerVoyageursTableView.voyageursTableView.indexPath(for: cell) else {
                    return
                }
                destController.voyageurSelected = destController.voyageurViewModel.get(voyageurAt: indexPath.row)
            }
        }
    }
    
    @IBAction func unwindToVoyageursView(segue: UIStoryboardSegue){
        if segue.identifier == "voyageurAddedSegue" {
            guard let controller = segue.source as? AjoutVoyageurViewController else { return }
            if let voyageur = controller.newVoyageur {
                self.controllerVoyageursTableView.voyageurs.add(voyageur: voyageur)
            }
            
        } else {
            //cas du cancel
            print("AJOUT ANNULE")
        }
    }
}

