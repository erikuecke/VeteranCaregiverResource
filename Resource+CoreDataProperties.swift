//
//  Resource+CoreDataProperties.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 9/6/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation
import CoreData


extension Resource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Resource> {
        return NSFetchRequest<Resource>(entityName: "Resource")
    }

    @NSManaged public var content: String?
    @NSManaged public var linkName: String?
    @NSManaged public var saved: Bool
    @NSManaged public var subjectsArray: [String]?
    @NSManaged public var subjectsString: String?
    @NSManaged public var title: String

}
