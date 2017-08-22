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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Configure text for Cell
    func configure(for resource: Resource) {
        if resource.title.isEmpty {
            titleLabel.text = "(No Description)"
        } else {
            titleLabel.text = resource.title
        }
        
        if (resource.content?.isEmpty)! {
           descriptionLabel.text = "(No Description)"
        } else {
            descriptionLabel.text = resource.content
        }
    }

}
