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
    
    // Website
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var websiteImage: UIImageView!
    
    // Share
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var shareImage: UIImageView!
    
    // Save
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var saveImage: UIImageView!
    
    
    var resourceToShow: Resource!
    
    var theSubjectsArray = [String]()
    var shareMessage = ""
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
        websiteImage.image = UIImage(named: "Web")
        shareImage.image = UIImage(named: "Share")
        
        if resourceToShow.saved == false {
            saveImage.image = UIImage(named: "unSaved")
            saveLabel.text = "Save"
            saveLabel.textColor = UIColor.black
        } else {
            saveImage.image = UIImage(named: "saved")
            saveLabel.text = "Saved"
            saveLabel.textColor = UIColor.green
        }
        theSubjectsArray = resourceToShow.subjectsArray!
        shareMessage = "I found this resource on the Veteran Cargiver Resource iPhone App and thought it might be useful for you. \n\n\(resourceToShow.title)\n\n\(resourceToShow.linkName!)\n\n \(resourceToShow.content!)"
       
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
            share(shareMessage)

        case (1, 2):
        // saveResource
            tableView.deselectRow(at: indexPath, animated: true)
            saveResource()
        default:
            return
        }
    }
    
    // Sharing Method UIActivityViewController
    func share(_ stringMessage: String) {
        
        let activityViewController = UIActivityViewController(activityItems: [stringMessage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    func saveResource() {
        if resourceToShow.saved == false {
            resourceToShow.saved = true
            saveImage.image = UIImage(named: "saved")
            saveLabel.text = "Saved"
            saveLabel.textColor = UIColor.green
        } else {
            resourceToShow.saved = false
            saveImage.image = UIImage(named: "unSaved")
            saveLabel.text = "Save"
            saveLabel.textColor = UIColor.black
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalCoreDataError(error)
        }
    }
   
    func fatalCoreDataError(_ error: Error) {
        print("*** Fatal error: \(error)")
        NotificationCenter.default.post( name: MyManagedObjectContextSaveDidFailNotification, object: nil)
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
