//
//	Result.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Result : NSObject, NSCoding{

	var geometry : Geometry!
	var icon : String!
	var id : String!
	var name : String!
	var openingHours : OpeningHour!
	var photos : [Photo]!
	var placeId : String!
	var rating : Int!
	var reference : String!
	var scope : String!
	var types : [String]!
	var vicinity : String!
    var isCheckIn : Bool!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let geometryData = dictionary["geometry"] as? NSDictionary{
			geometry = Geometry(fromDictionary: geometryData)
		}
		icon = dictionary["icon"] as? String
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		if let openingHoursData = dictionary["opening_hours"] as? NSDictionary{
			openingHours = OpeningHour(fromDictionary: openingHoursData)
		}
		photos = [Photo]()
		if let photosArray = dictionary["photos"] as? [NSDictionary]{
			for dic in photosArray{
				let value = Photo(fromDictionary: dic)
				photos.append(value)
			}
		}
		placeId = dictionary["place_id"] as? String
		rating = dictionary["rating"] as? Int
		reference = dictionary["reference"] as? String
		scope = dictionary["scope"] as? String
		types = dictionary["types"] as? [String]
		vicinity = dictionary["vicinity"] as? String
        isCheckIn = dictionary["is_checkin"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let
        dictionary = NSMutableDictionary()
		if geometry != nil{
			dictionary["geometry"] = geometry.toDictionary()
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if openingHours != nil{
			dictionary["opening_hours"] = openingHours.toDictionary()
		}
		if photos != nil{
			var dictionaryElements = [NSDictionary]()
			for photosElement in photos {
				dictionaryElements.append(photosElement.toDictionary())
			}
			dictionary["photos"] = dictionaryElements
		}
		if placeId != nil{
			dictionary["place_id"] = placeId
		}
		if rating != nil{
			dictionary["rating"] = rating
		}
		if reference != nil{
			dictionary["reference"] = reference
		}
		if scope != nil{
			dictionary["scope"] = scope
		}
		if types != nil{
			dictionary["types"] = types
		}
		if vicinity != nil{
			dictionary["vicinity"] = vicinity
		}
        if isCheckIn != nil {
            dictionary["is_checkin"] = isCheckIn
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         geometry = aDecoder.decodeObject(forKey: "geometry") as? Geometry
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         openingHours = aDecoder.decodeObject(forKey: "opening_hours") as? OpeningHour
         photos = aDecoder.decodeObject(forKey: "photos") as? [Photo]
         placeId = aDecoder.decodeObject(forKey: "place_id") as? String
         rating = aDecoder.decodeObject(forKey: "rating") as? Int
         reference = aDecoder.decodeObject(forKey: "reference") as? String
         scope = aDecoder.decodeObject(forKey: "scope") as? String
         types = aDecoder.decodeObject(forKey: "types") as? [String]
         vicinity = aDecoder.decodeObject(forKey: "vicinity") as? String
         isCheckIn = aDecoder.decodeObject(forKey: "is_checkin") as? Bool
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder) {

        if geometry != nil{
			aCoder.encode(geometry, forKey: "geometry")
		}
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if openingHours != nil{
			aCoder.encode(openingHours, forKey: "opening_hours")
		}
		if photos != nil{
			aCoder.encode(photos, forKey: "photos")
		}
		if placeId != nil{
			aCoder.encode(placeId, forKey: "place_id")
		}
		if rating != nil{
			aCoder.encode(rating, forKey: "rating")
		}
		if reference != nil{
			aCoder.encode(reference, forKey: "reference")
		}
		if scope != nil{
			aCoder.encode(scope, forKey: "scope")
		}
		if types != nil{
			aCoder.encode(types, forKey: "types")
		}
		if vicinity != nil{
			aCoder.encode(vicinity, forKey: "vicinity")
		}
        if isCheckIn != nil{
            aCoder.encode(isCheckIn, forKey: "is_checkin")
        }
	}
}
