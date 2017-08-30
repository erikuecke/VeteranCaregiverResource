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

class ResourceDetailViewController: UIViewController {
    
    
    
    // ManagedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    
    var resourceToShow: Resource!
    
    var linkName: String = ""
    
    @IBOutlet weak var webView: UIWebView!
    
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        linkName = resourceToShow.linkName!
        
        if let url = URL(string: linkName) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
}
