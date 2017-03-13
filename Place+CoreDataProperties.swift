//
//  Place+CoreDataProperties.swift
//  
//
//  Created by  on 1/19/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place");
    }

    @NSManaged public var name: String?
    @NSManaged public var uniqueID: String?
    @NSManaged public var visited: Bool
    @NSManaged public var challenge: Challenge?

}
