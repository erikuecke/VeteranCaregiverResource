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
        "Other Service & Resources"]
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
    
    // Prepare for Seguew to pick category
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let controller = segue.destination as! SearchListViewController
            controller.title = "Search All"
            controller.managedObjectContext = managedObjectContext
        }
    }
    
}


