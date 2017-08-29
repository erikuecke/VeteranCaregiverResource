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

class SearchListViewController: UITableViewController, UISearchBarDelegate {
    
    // 1 Create search Controller
    let searchController = UISearchController(searchResultsController: nil)
    
    // ManagedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    
    // Subject Filter
    var subjectFilter: String?
    
    // Predicate filter
    var testPredicate: NSPredicate?

    
    
    //NSFetchedResultsController
    lazy var fetchedResultsController: NSFetchedResultsController<Resource> = {
        
        let fetchRequest = NSFetchRequest<Resource>()
        
        let entity = Resource.entity()
        fetchRequest.entity = entity
        
        let sortDescriptor1 = NSSortDescriptor(key: "title", ascending: true)
        
        
        fetchRequest.sortDescriptors = [sortDescriptor1]
        // NSPredicate default
//        fetchRequest.predicate = NSPredicate(format: "subjects containts[c] %@", "Health")
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
        

        performFetch()
        
        // 3 Set up SearchController parameters
        // Setup the Search Controller
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.delegate = self
        
        
    }
    
    
    
    func performFetch() {
        
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: "Resources")
        if !isFiltering(), subjectFilter != nil {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "subjects containts[c] %@", subjectFilter!)
        }
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalCoreDataError(error)
        }
    }
   

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
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

    
 
    // 5
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        if !searchBarIsEmpty() {
            NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: "Resources")
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", searchText)
            
        } else {
            fetchedResultsController.fetchRequest.predicate = nil
        }
        
        
        performFetch()
        
        tableView.reloadData()
    }
    
    // 7
    // Currently Filtering methods
    func isFiltering() -> Bool {
        
        // 14
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    
}

// 2
extension SearchListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension SearchListViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        performFetch()
        self.tableView.reloadData()
    }
}

// FilterViewController: NSFetchedResultsControllerDelegate
extension SearchListViewController: NSFetchedResultsControllerDelegate {
    
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


