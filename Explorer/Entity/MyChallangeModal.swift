//
//  MyChallangeModal.swift
//  Explorer
//
//  Created by Team Cookie on 02/03/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import Foundation

class MyChallangeModal : NSObject, NSCoding{
    
    var id: Int64!
    var name: String!
    var distance: String!
    var type: String!
    var result: NSData!
    var isBadge : Bool!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary[keyId] as? Int64
        name = dictionary[keyName] as? String
        distance = dictionary[keyDistance] as? String
        result = dictionary[keyResult] as? NSData
        type = dictionary[keyType] as? String
        isBadge = dictionary[keyBadge] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if id != nil{
            dictionary[keyId] = id
        }
        if name != nil{
            dictionary[keyName] = name
        }
        if distance != nil{
            dictionary[keyDistance] = distance
        }
        if result != nil{
            dictionary[keyResult] = result
        }
        if type != nil{
            dictionary[keyType] = type
        }
        if isBadge != nil{
            dictionary[keyBadge] = isBadge
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: keyId) as? Int64
        name = aDecoder.decodeObject(forKey: keyName) as? String
        distance = aDecoder.decodeObject(forKey: keyDistance) as? String
        type = aDecoder.decodeObject(forKey: keyType) as? String
        isBadge = aDecoder.decodeObject(forKey: keyBadge) as? Bool
        result = aDecoder.decodeObject(forKey: keyResult) as? NSData
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder) {
        
        if id != nil {
            aCoder.encode(id, forKey: keyId)
        }
        
        if name != nil{
            aCoder.encode(name, forKey: keyName)
        }
        
        if distance != nil {
            aCoder.encode(distance, forKey: keyDistance)
        }
        
        if result != nil {
            aCoder.encode(result, forKey: keyResult)
        }
        
        if type != nil {
            aCoder.encode(type, forKey: keyType)
        }
        
        if isBadge != nil {
            aCoder.encode(isBadge, forKey: keyBadge)
        }
    }
}
