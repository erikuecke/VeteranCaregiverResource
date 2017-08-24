//
//  Resource+CoreDataProperties.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/24/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import CoreData


extension Resource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Resource> {
        return NSFetchRequest<Resource>(entityName: "Resource")
    }

    @NSManaged public var content: String?
    @NSManaged public var geographicServiceLocations: [[String: AnyObject]]?
    @NSManaged public var linkName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var saved: Bool
    @NSManaged public var subjects: [String]?
    @NSManaged public var title: String

}
