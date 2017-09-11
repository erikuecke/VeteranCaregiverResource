//
//  Animations.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 9/11/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension VAClient {
    
    
    struct Animations {
        static var activityIndicator = UIActivityIndicatorView()
        // Start activity animation
        static func beginActivityIndicator(view: UIView, activityIndicator: UIActivityIndicatorView = activityIndicator) {
            view.alpha = CGFloat(0.75)
            
            activityIndicator.center = view.center
            activityIndicator.activityIndicatorViewStyle = .whiteLarge
            activityIndicator.color = UIColor.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        // End Activity animation
        static func endActivityIndicator(view: UIView, activityIndicator: UIActivityIndicatorView = activityIndicator) {
            activityIndicator.stopAnimating()
            view.alpha = CGFloat(1.00)
            view.reloadInputViews()
            
        }
    }
}
