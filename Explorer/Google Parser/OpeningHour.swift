//
//	OpeningHour.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class OpeningHour : NSObject, NSCoding {

	var exceptionalDate : [AnyObject]!
	var openNow : Bool!
	var weekdayText : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		exceptionalDate = dictionary["exceptional_date"] as? [AnyObject]
		openNow = dictionary["open_now"] as? Bool
		weekdayText = dictionary["weekday_text"] as? [AnyObject]
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if exceptionalDate != nil{
			dictionary["exceptional_date"] = exceptionalDate
		}
		if openNow != nil{
			dictionary["open_now"] = openNow
		}
		if weekdayText != nil{
			dictionary["weekday_text"] = weekdayText
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         exceptionalDate = aDecoder.decodeObject(forKey: "exceptional_date") as? [AnyObject]
         openNow = aDecoder.decodeObject(forKey: "open_now") as? Bool
         weekdayText = aDecoder.decodeObject(forKey: "weekday_text") as? [AnyObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder) {

        if exceptionalDate != nil{
			aCoder.encode(exceptionalDate, forKey: "exceptional_date")
		}
		if openNow != nil{
			aCoder.encode(openNow, forKey: "open_now")
		}
		if weekdayText != nil{
			aCoder.encode(weekdayText, forKey: "weekday_text")
		}
	}
}
