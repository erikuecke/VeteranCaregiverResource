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

    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    
    
    var resourceToShow: Resource!
    
    var theSubjectsArray = [String]()

    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
    


    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialization code
        titleCollectionView.isScrollEnabled = false
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
        
        titleLabel.text = resourceToShow.title
        contentLabel.text = resourceToShow.content
        theSubjectsArray = resourceToShow.subjectsArray!
        print(theSubjectsArray)
       
    }
    
    // TABLEVIEW 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            // openWeblink
            tableView.deselectRow(at: indexPath, animated: true)
            if let url = URL(string: resourceToShow.linkName!) {
                UIApplication.shared.open(url, options: [:])
            }

        case (1, 1):
        // shareResource
            
            
            tableView.deselectRow(at: indexPath, animated: true)
            // acitivityviewcontroller
            print("share Resource")
            
        case (1, 2):
        // saveResource
            tableView.deselectRow(at: indexPath, animated: true)
            print("saveResrouce")
            if resourceToShow.saved == true {
                resourceToShow.saved = false
                
                
            }
        default:
            return
        }
    }
    
    // Sharing Method UIActivityViewController
    func sfhare() {
        
        let activityViewController = UIActivityViewController(activityItems: [resourceToShow.title], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    

    
}

// For Title Cell Colleciton view
extension ResourceDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("nuberofitems insection")
        return theSubjectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! IconCollectionViewCell
        
        cell.collectionImageView.image = UIImage(named: "\(theSubjectsArray[indexPath.row])")
        print("Cellforitem at")
        return cell
    }
}

extension ResourceDetailViewController: UICollectionViewDelegate {
    
}
