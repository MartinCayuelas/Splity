//
//  VoyageFetchResultController.swift
//  ProjetSwift
//
//  Created by Nathan GUILLAUD on 25/03/2019.
//  Copyright © 2019 Nathan GUILLAUD et Martin CAYUELAS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VoyageFetchResultController: NSObject, NSFetchedResultsControllerDelegate{
    let tableView  : UITableView
    //let personsSet : PersonSetViewModel
    
    init(view : UITableView){//}, model : PersonSetViewModel){
        self.tableView  = view
        //self.personsSet = model
        super.init()
        do{
            try self.voyagesFetched.performFetch()
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    lazy var voyagesFetched : NSFetchedResultsController<Voyage> = {
        // prepare a request
        let request : NSFetchRequest<Voyage> = Voyage.fetchRequest()
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Voyage.pTitreVoyage),ascending:true),NSSortDescriptor(key:#keyPath(Voyage.pPhotoVoyage)
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
