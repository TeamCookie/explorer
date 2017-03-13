//
//  MyChallenges+CoreDataProperties.swift
//  
//
//  Created by Team Cookie on 02/03/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension MyChallenges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyChallenges> {
        return NSFetchRequest<MyChallenges>(entityName: "MyChallenges");
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var distance: String?
    @NSManaged public var result: NSData?
    @NSManaged public var isBadge: Bool
    @NSManaged public var type: String?
}
