//
//  GCDBlackBox.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 9/11/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//


import Foundation

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
