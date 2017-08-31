//
//  ResourceDetailViewController.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/30/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import WebKit

class ResourceDetailViewController: UITableViewController {
    
    // ManagedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    
    // Label/textview outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    
    var resourceToShow: Resource!

    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
    


    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = resourceToShow.title
        contentLabel.text = resourceToShow.content
        
        
    }
}
