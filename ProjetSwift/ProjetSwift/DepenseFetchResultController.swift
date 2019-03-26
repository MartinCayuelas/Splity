//
//  DepenseFetchResultController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 26/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DepenseFetchResultController: NSObject, NSFetchedResultsControllerDelegate{
    let tableView  : UITableView
    //let personsSet : PersonSetViewModel
    
    init(view : UITableView){//}, model : PersonSetViewModel){
        self.tableView  = view
        //self.personsSet = model
        super.init()
        do{
            try self.depensesFetched.performFetch()
        }
        catch let error as NSError{
            fatalError(error.description)
        }
        
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    lazy var depensesFetched : NSFetchedResultsController<Depense> = {
        // prepare a request
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Depense.pTitreDepense),ascending:true),NSSortDescriptor(key:#keyPath(Depense.pDateDepense)
                ,ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext:
            CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at
        indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath{
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } default:
            break
        }
        
    }
}
