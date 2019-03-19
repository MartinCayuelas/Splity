//
//  VoyagesViewController.swift
//  ProjetSwift
//
//  Created by Martin Cayuelas on 19/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import UIKit

class VoyagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    
    @IBOutlet weak var tableView: UITableView!
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? DetailVoyageViewController {
            if let cell = sender as? UITableViewCell {
                guard let indexPath = self.tableView.indexPath(for: cell) else {
                    return
                }
                destController.voyageSelected = destController.voyageViewModel.getVoyage(at: indexPath)
            }
        }
    }
 

}
