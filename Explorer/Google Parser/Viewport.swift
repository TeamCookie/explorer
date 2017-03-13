//
//	Viewport.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Viewport : NSObject, NSCoding{

	var northeast : Location!
	var southwest : Location!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let northeastData = dictionary["northeast"] as? NSDictionary{
			northeast = Location(fromDictionary: northeastData)
		}
		if let southwestData = dictionary["southwest"] as? NSDictionary{
			southwest = Location(fromDictionary: southwestData)
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if northeast != nil{
			dictionary["northeast"] = northeast.toDictionary()
		}
		if southwest != nil{
			dictionary["southwest"] = southwest.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         northeast = aDecoder.decodeObject(forKey: "northeast") as? Location
         southwest = aDecoder.decodeObject(forKey: "southwest") as? Location

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder) {

        if northeast != nil{
			aCoder.encode(northeast, forKey: "northeast")
		}
		if southwest != nil{
			aCoder.encode(southwest, forKey: "southwest")
		}

	}

}
