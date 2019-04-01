//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 11/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    var controllerVoyageursTableView: VoyageursTableViewController!
    @IBOutlet weak var voyageursTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.controllerVoyageursTableView = VoyageursTableViewController(tableView: voyageursTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.controllerVoyageursTableView.voyageurs = VoyageurSetViewModel(voyageurs: VoyageurDAO.getAllVoyageursNonArchives())
        self.voyageursTableView.reloadData()
        print(self.controllerVoyageursTableView.voyageurs.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /// Appelé lorsqu'un que l'on clique sur la une cellule de la liste des voyageurs
 ///
 /// - Parameters: segue et sender
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? VoyagesViewController {
            if let cell = sender as? UITableViewCell {
                guard let indexPath = self.controllerVoyageursTableView.voyageursTableView.indexPath(for: cell) else {
                    return
                }
                destController.voyageurSelected = self.controllerVoyageursTableView.voyageurs.get(voyageurAt: indexPath.row)
            }
        }
        if segue.identifier == "voyageurAddedSegue" {
            guard let controller = segue.destination as? AjoutVoyageurViewController else { return }
            controller.pagePrecedente = "Accueil"
        }
    }
    
 /// Appelé lorsqu'un que l'on ajoute un voyageur à la liste
 /// - Permet de retourner à la liste de voyageurs avec le nouveau voyageur ajouté
 /// - Parameters: segue 
    
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

