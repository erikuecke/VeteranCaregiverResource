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
        backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        titleLabel?.textColor = UIColor.white
        // Initialization code
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


    
    // Configure text for Cell
    func configure(for resource: Resource) {
        subjectsArray = resource.subjectsArray!
        if resource.title.isEmpty {
            titleLabel.text = "(No Description)"
        } else {
            titleLabel.text = resource.title
        }
        
        photoImageView.image = thumbnail(for: resource)
        collectionView.reloadData()
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

extension ResourceCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! IconCollectionViewCell
        
        cell.collectionImageView.image = UIImage(named: "\(subjectsArray[indexPath.row])")
        
        return cell
    }
}

extension ResourceCell: UICollectionViewDelegate {
    
}
    
    


