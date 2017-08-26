//
//  ResourceCell.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/22/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import UIKit
import CoreData

class ResourceCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    // Collection Image
    
    var subjectsArray = [String]()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


    
    // Configure text for Cell
    func configure(for resource: Resource) {
        subjectsArray = resource.subjects!
        if resource.title.isEmpty {
            titleLabel.text = "(No Description)"
        } else {
            titleLabel.text = resource.title
        }
        
        photoImageView.image = thumbnail(for: resource)
        
        
        
    }
    
    // Add image to cell
    func thumbnail(for resource: Resource) -> UIImage {
        
        if resource.saved  {
            return UIImage(named: "saved")!
        } else {
            return UIImage(named: "unSaved")!
        }
        
  
    }


}

//extension ResourceCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return subjectsArray.count
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        //
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCollectionViewCell", for: indexPath) as! IconCollectionViewCell
//        
//        cell.collectionImageView.image = UIImage(named: "\(subjectsArray[indexPath.row])")
//        
// 
//
//        return cell
//    }
    
    
}

