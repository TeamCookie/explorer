//
//  Challenge+CoreDataProperties.swift
//  
//
//  Created by June Yoshii on 1/19/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge");
    }

    @NSManaged public var challengeType: String?
    @NSManaged public var city: String?
    @NSManaged public var completed: Bool
    @NSManaged public var name: String?
    @NSManaged public var places: NSOrderedSet?

}

// MARK: Generated accessors for places
extension Challenge {

    @objc(insertObject:inPlacesAtIndex:)
    @NSManaged public func insertIntoPlaces(_ value: Place, at idx: Int)

    @objc(removeObjectFromPlacesAtIndex:)
    @NSManaged public func removeFromPlaces(at idx: Int)

    @objc(insertPlaces:atIndexes:)
    @NSManaged public func insertIntoPlaces(_ values: [Place], at indexes: NSIndexSet)

    @objc(removePlacesAtIndexes:)
    @NSManaged public func removeFromPlaces(at indexes: NSIndexSet)

    @objc(replaceObjectInPlacesAtIndex:withObject:)
    @NSManaged public func replacePlaces(at idx: Int, with value: Place)

    @objc(replacePlacesAtIndexes:withPlaces:)
    @NSManaged public func replacePlaces(at indexes: NSIndexSet, with values: [Place])

    @objc(addPlacesObject:)
    @NSManaged public func addToPlaces(_ value: Place)

    @objc(removePlacesObject:)
    @NSManaged public func removeFromPlaces(_ value: Place)

    @objc(addPlaces:)
    @NSManaged public func addToPlaces(_ values: NSOrderedSet)

    @objc(removePlaces:)
    @NSManaged public func removeFromPlaces(_ values: NSOrderedSet)

}
