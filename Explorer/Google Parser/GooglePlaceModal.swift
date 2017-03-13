//
//	GooglePlaceModal.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GooglePlaceModal : NSObject, NSCoding{

	var htmlAttributions : [AnyObject]!
	var nextPageToken : String!
	var results : [Result]!
	var status : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		htmlAttributions = dictionary["html_attributions"] as? [AnyObject]
		nextPageToken = dictionary["next_page_token"] as? String
		results = [Result]()
		if let resultsArray = dictionary["results"] as? [NSDictionary]{
			for dic in resultsArray{
				let value = Result(fromDictionary: dic)
				results.append(value)
			}
		}
		status = dictionary["status"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if htmlAttributions != nil{
			dictionary["html_attributions"] = htmlAttributions
		}
		if nextPageToken != nil{
			dictionary["next_page_token"] = nextPageToken
		}
		if results != nil{
			var dictionaryElements = [NSDictionary]()
			for resultsElement in results {
				dictionaryElements.append(resultsElement.toDictionary())
			}
			dictionary["results"] = dictionaryElements
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         htmlAttributions = aDecoder.decodeObject(forKey:
            "html_attributions") as? [AnyObject]
         nextPageToken = aDecoder.decodeObject(forKey: "next_page_token") as? String
         results = aDecoder.decodeObject(forKey: "results") as? [Result]
         status = aDecoder.decodeObject(forKey: "status") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder) {
        
		if htmlAttributions != nil{
			aCoder.encode(htmlAttributions, forKey: "html_attributions")
		}
		if nextPageToken != nil{
			aCoder.encode(nextPageToken, forKey: "next_page_token")
		}
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
	}
}
