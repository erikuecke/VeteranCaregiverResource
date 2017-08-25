//
//  SearchListViewController.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/25/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchListViewController: UITableViewController {
    
    // ManagedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    
    
    //NSFetchedResultsController
    lazy var fetchedResultsController: NSFetchedResultsController<Resource> = {
        
        let fetchRequest = NSFetchRequest<Resource>()
        
        let entity = Resource.entity()
        fetchRequest.entity = entity
        
        let sortDescriptor1 = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor1]
        //NSCompoundPredicate(type: .AndPredicateType, subpredicates: [NSPredicate(format: "age > 25"), NSPredicate(format: "firstName = %@", "Quentin")])
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [NSPredicate(format: "subjects contains[c] %@", "Housing"), NSPredicate(format: "subjects contains[c] %@", "Health")])
        
        //        let textCompoundPRedicate = NSCompoundPredicate(o)
        // NSPredicate(format: "name contains[c] %@ AND nickName contains[c] %@", argumentArray: [name, nickname])
        fetchRequest.predicate = compoundPredicate
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: "Resources")
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    deinit {
        fetchedResultsController.delegate = nil
    }
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("it loaded at least")
        performFetch()
        
    }
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalCoreDataError(error)
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections?[section]
        print("number of objects is: \(sectionInfo!.numberOfObjects)")
        return sectionInfo!.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! ResourceCell
        
        let resource = fetchedResultsController.object(at: indexPath)
        cell.configure(for: resource)
        
        
        
        return cell
    }

    
    // Configureing Cell
    

    
}

// FilterViewController: NSFetchedResultsControllerDelegate
extension FilterViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("*** controllerWillChangeContent")
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            print("*** NSFetchedResultsChangeInsert (object)")
            tableView.insertRows(at: [newIndexPath!], with: .fade)
            
        case .delete:
            print("*** NSFetchedResultsChangeDelete (object)")
            tableView.deleteRows(at: [indexPath!], with: .fade)
            
        case .update:
            print("*** NSFetchedResultsChangeUpdate (object)")
            if let cell = tableView.cellForRow(at: indexPath!) as? ResourceCell {
                let resource = controller.object(at: indexPath!) as! Resource
                cell.configure(for: resource)
            }
            
        case .move:
            print("*** NSFetchedResultsChangeMove (object)")
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            print("*** NSFetchedResultsChangeInsert (section)")
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            print("*** NSFetchedResultsChangeDelete (section)")
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .update:
            print("*** NSFetchedResultsChangeUpdate (section)")
        case .move:
            print("*** NSFetchedResultsChangeMove (section)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("*** controllerDidChangeContent")
        tableView.endUpdates()
    }
}
