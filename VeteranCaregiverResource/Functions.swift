//
//  Functions.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/22/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import Dispatch
import CoreData

// Fatal Error
let MyManagedObjectContextSaveDidFailNotification = Notification.Name( rawValue: "MyManagedObjectContextSaveDidFailNotification")

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post( name: MyManagedObjectContextSaveDidFailNotification, object: nil)
}

// Checking core data file path
let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask )
    return paths[0]
}()

