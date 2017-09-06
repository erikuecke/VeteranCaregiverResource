//
//  FilterCell.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 9/5/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        filterLabel.textColor = UIColor.white
        
    
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
