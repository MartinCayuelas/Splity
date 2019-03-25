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
    
    
    @IBAction func supprimerVoyageur(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.voyageursTableView)
        if let indexPath = self.voyageursTableView.indexPathForRow(at: buttonPosition){
            voyageursTableView.beginUpdates()
            VoyageurDAO.delete(voyageur: self.controllerVoyageursTableView.voyageurs.get(voyageurAt: indexPath.row)!)
            VoyageurDAO.save()
            voyageursTableView.deleteRows(at: [indexPath], with: .fade)
           
            voyageursTableView.endUpdates()
        }
    }
    
    
    
}

