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
        
        // table color
        tableView.backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        tableView.separatorColor = UIColor(red: 79/255.0, green: 102/255.0, blue: 140/255.0, alpha: 1.0)
        tableView.indicatorStyle = .default
        
        // Initialization code
        titleCollectionView.backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        titleCollectionView.isScrollEnabled = false
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
        
        titleLabel.text = resourceToShow.title
        titleLabel.textColor = UIColor.white
        
        contentLabel.text = resourceToShow.content
        
        websiteImage.image = UIImage(named: "Web")
        websiteLabel.textColor = UIColor.white
        
        shareImage.image = UIImage(named: "Share")
        shareLabel.textColor = UIColor.white
        
        if resourceToShow.saved == false {
            saveImage.image = UIImage(named: "unSaved")
            saveLabel.text = "Save"
            saveLabel.textColor = UIColor.white
        } else {
            saveImage.image = UIImage(named: "saved")
            saveLabel.text = "Saved"
            saveLabel.textColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0)
        }
        theSubjectsArray = resourceToShow.subjectsArray!
        shareMessage = "I found this resource on the Veteran Cargiver Resource iPhone App and thought it might be useful for you. \n\n\(resourceToShow.title)\n\n\(resourceToShow.linkName!)\n\n \(resourceToShow.content!)"
       
    }
    
    // Customize static cells
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
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
            saveLabel.textColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0)
        } else {
            resourceToShow.saved = false
            saveImage.image = UIImage(named: "unSaved")
            saveLabel.text = "Save"
            saveLabel.textColor = UIColor.white
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
        
        return theSubjectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! IconCollectionViewCell
        
        cell.collectionImageView.image = UIImage(named: "\(theSubjectsArray[indexPath.row])")
       
        return cell
    }
}

extension ResourceDetailViewController: UICollectionViewDelegate {
    
}
