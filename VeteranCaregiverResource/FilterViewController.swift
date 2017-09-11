//
//  FilterViewController.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/22/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FilterViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var rowHeight: CGFloat!
    
    let icons = [
        "All",
        "Health",
        "Benefits & Compensation",
        "Housing",
        "Education & Training",
        "Employment",
        "Family & Caregiver Support",
        "Transportation & Travel",
        "Homeless Assistance",
        "Other Services & Resources"]
    
    
    
    // View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForData()
        let barHeightInt = Int((self.navigationController?.navigationBar.frame.size.height)!) + Int((self.tabBarController?.tabBar.frame.size.height)!) + Int(UIApplication.shared.statusBarFrame.size.height)
        
        let tableHeight = Int(tableView.frame.size.height) - barHeightInt
        
        tableView.rowHeight = CGFloat(tableHeight / icons.count)
       
        tableView.backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        tableView.separatorColor = UIColor(red: 79/255.0, green: 102/255.0, blue: 140/255.0, alpha: 1.0)
        tableView.indicatorStyle = .default
        
        
        
    }
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        
        let iconName = icons[indexPath.row]
        
        cell.filterLabel.text = iconName
        cell.filterImage.image = UIImage(named: iconName)
        
        return cell
    }
    
    // Prepare for Seguew to pick category
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let controller = segue.destination as! SearchListViewController
            controller.title = "Search All"
            controller.managedObjectContext = managedObjectContext
        } else if segue.identifier == "FilterSegue" {
            let controller = segue.destination as! SearchListViewController
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                let cell = tableView.cellForRow(at: indexPath) as! FilterCell
                
                let subjectFilter = cell.filterLabel.text
                controller.title = subjectFilter
                if subjectFilter == "All" {
                    controller.subjectFilter = nil
                } else {
                   controller.subjectFilter = subjectFilter!
                }
                
            }
            controller.managedObjectContext = managedObjectContext
        }
    }
    
    var resources = [Resource]()
    func checkForData() {
        
        // Activity indicator
        performUIUpdatesOnMain {
            VAClient.Animations.beginActivityIndicator(view: self.view)
        }
        
        let fetchRequest = NSFetchRequest<Resource>()
        // 2
        let entity = Resource.entity()
        fetchRequest.entity = entity
        // 3
        
        do {
            // 4
            resources = try managedObjectContext.fetch(fetchRequest)
        } catch {
            fatalCoreDataError(error)
        }
        
        
        
        if resources.count == 0 {
            VAClient.sharedInstance().getVAResources(completionHandlerForGetVAResources: { ( arrayOfResources, error) in
                
                if let arrayOfResources = arrayOfResources {
                    self.saveInCoreDataWith(array: arrayOfResources)
                    performUIUpdatesOnMain {
                        VAClient.Animations.endActivityIndicator(view: self.view)
                    }
                } else {
                    let errorString = String(describing: error)
                    performUIUpdatesOnMain {
                        VAClient.Animations.endActivityIndicator(view: self.view)
                    }
                    self.errorAlert(errorString)
                }
                
                
            })
            
            
        } else {
            performUIUpdatesOnMain {
                VAClient.Animations.endActivityIndicator(view: self.view)
            }
//            print("Core Data Full")
        }
    }
    
    // Save in core data method
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createResourceEntityFrom(dictionary: $0)}
        
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // Create Intity from Array Dict
    private func createResourceEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        if let resourceEntity = NSEntityDescription.insertNewObject(forEntityName: "Resource", into: managedObjectContext) as? Resource {
            resourceEntity.title = dictionary["title"] as! String
            resourceEntity.content = dictionary["content"] as? String
            // Subjects array into string to sort
            let subjectsString = { () -> String in
                var stringFromArray = ""
                for subject in dictionary["subjects"] as! [String] {
                    stringFromArray = stringFromArray + "\(subject) "
                }
                return stringFromArray
            }
            resourceEntity.subjectsString = subjectsString()
            resourceEntity.subjectsArray = dictionary["subjects"] as? [String]
            resourceEntity.linkName = dictionary["linkName"] as? String
            resourceEntity.saved = false
            
            return resourceEntity
        }
        return nil
    }
    
}

// For all error alerts in viewcontrollers
extension UIViewController {
    func errorAlert(_ errorString: String) {
        let alertController = UIAlertController(title: "Error", message: "Unable to retrieve the resource list. Please check your network connetion and try the refresh button.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}



