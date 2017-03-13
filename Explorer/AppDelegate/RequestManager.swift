//
//  RequestManager.swift
//  Explorer
//
//  Created by Developer on 01/03/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD
import AFNetworking

//https://maps.googleapis.com/maps/api/place/search/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&sensor=false&key=

let kAPISignUp = "signup"
let kAPIGooglePlaceSearch = "place/search/json"
let kAPIGoogleGeoCodeSearch = "geocode/json"

class RequestManager : NSObject {
    
    static var singleton = RequestManager()
    
    let kBaseURL = "https://maps.googleapis.com/maps/api/"
    
    let messageNoIntenetConnection = "No intenet connection"
    let messageParsingError = "No valid response"
    let messageNoRecordFound = "No record found"
    
    var apiManager : AFHTTPSessionManager {
        
        let manager = AFHTTPSessionManager()
        
        manager.responseSerializer = AFJSONResponseSerializer()
        
        let codeToAccept = NSMutableIndexSet()
        codeToAccept.add(400)
        codeToAccept.add(200)
        codeToAccept.add(201)
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json"];
        manager.responseSerializer.acceptableStatusCodes = codeToAccept as IndexSet
        
        return manager
    }
    
    func requestGET(requestMethod : String, parameters : [String: AnyObject], showLoader : Bool, successBlock:@escaping ((_ response : NSDictionary)->Void), failureBlock:@escaping ((_ response : NSDictionary?, _ error : Error?) -> Void)) {
        
        if !AFNetworkReachabilityManager.shared().isReachable {
            messageBox(message: messageNoIntenetConnection)
            failureBlock(nil, nil)
            return
        }
        
        //let requestURL = kBaseURL.appending(requestMethod)
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = URL(string:"\(kBaseURL)\(requestMethod)?\(parameterString)")!
        
        debugPrint("------------- Start -------------");
        print("requestURL :- \(requestURL)");
        
        //let escapedString = requestURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let escapedString = requestURL.absoluteString
        
        let window = AppDelegate.singleton.window?.rootViewController
        var hud = MBProgressHUD()
        
        if showLoader && window != nil {
            
            hud = MBProgressHUD.showAdded(to: window!.view, animated: true)
            hud.mode = .indeterminate
            hud.label.text = "Loading";
            hud.animationType = .zoomIn
            hud.tintColor = UIColor.black
            hud.contentColor = UIColor.lightGray
        }
        
        let manager = apiManager
        
        manager.get(escapedString, parameters: nil,progress: { (data) in
            
        }, success: { (dataTask, response) in
            
            if showLoader {
                hud.hide(animated: true)
            }
            
            if let data = (response as? NSDictionary)?.object(forKey: "response") as? NSDictionary {
                
                print("response :- \(data)");
                
                debugPrint("------------- End -------------");
                
                if (data.value(forKeyPath: "code") as! String) == "200" {
                    successBlock(data)
                } else {
                     failureBlock(data, nil)
                }
            } else if let data = (response as? NSArray) {
                
                print("response :- \(data)");
                
                debugPrint("------------- End -------------");
                
                if data.count > 0 {
                    
                    let dict = NSDictionary(dictionary: [requestMethod : data])
                    successBlock(dict)
                    
                } else {
                    
                    let dict = NSDictionary(dictionary: [requestMethod : []])
                    failureBlock(dict, nil)
                }
            } else if let data = (response as? NSDictionary) {
                
                print("response :- \(data)");
                
                debugPrint("------------- End -------------");
                
                successBlock(data)
                
            } else {
                messageBox(message: self.messageParsingError)
            }
            
        }) { (dataTask, error) in
            
            if showLoader {
                hud.hide(animated: true)
            }
            messageBox(message: error.localizedDescription)
            print("error :- \(error.localizedDescription)");
            debugPrint("------------- End -------------");
            failureBlock(nil, error)
        }
    }
    
    func requestPOST(requestMethod : String, parameter : NSDictionary, showLoader : Bool, successBlock:@escaping ((_ response : NSDictionary)->Void), failureBlock:@escaping ((_ response : NSDictionary?, _ error : Error?) -> Void)) {
        
        if !AFNetworkReachabilityManager.shared().isReachable {
            messageBox(message: messageNoIntenetConnection)
            return
        }
        
        let requestURL = kBaseURL.appending(requestMethod)
        
        debugPrint("------------- Start -------------");
        print("requestURL :- \(requestURL)");
        
        let escapedString = requestURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        
        let window = AppDelegate.singleton.window?.rootViewController
        var hud : MBProgressHUD
        
        if showLoader && window != nil {
            hud = MBProgressHUD .showAdded(to: window!.view, animated: true)
        } else {
            hud = MBProgressHUD()
        }
        hud.mode = .indeterminate
        hud.label.text = "Loading";
        hud.animationType = .zoomIn
        hud.tintColor = UIColor.black
        hud.contentColor = UIColor.lightGray
        
        print("parameter :- \(parameter)");
        
        let manager = apiManager

        manager.post(escapedString!, parameters: parameter, progress: { (data) in
            
        }, success: { (dataTask, response) in
            
            if showLoader {
                hud.hide(animated: true)
            }
            
            if let data = (response as? NSDictionary)?.object(forKey: "response") as? NSDictionary {
                
                print("response :- \(data)");
                
                debugPrint("------------- End -------------");
                
                if (data.value(forKeyPath: "code") as! String) == "200" {
                    successBlock(data)
                } else {
                    failureBlock(data, nil)
                }
                
            } else {
                messageBox(message: self.messageParsingError)
            }
            
        }) { (dataTask, error) in
            
            if showLoader {
                hud.hide(animated: true)
            }
            messageBox(message: error.localizedDescription)
            print("error :- \(error.localizedDescription)");
            debugPrint("------------- End -------------");
            failureBlock(nil, error)
        }
    }
    
    func requestMultipartPOST(requestMethod : String, parameter : NSDictionary, showLoader : Bool, name : String, images : [UIImage], successBlock:@escaping ((_ response : NSDictionary)->Void), failureBlock:@escaping ((_ response : NSDictionary?, _ error : Error?) -> Void)) {
        
        if !AFNetworkReachabilityManager.shared().isReachable {
            messageBox(message: messageNoIntenetConnection)
            return
        }
        
        let requestURL = kBaseURL.appending(requestMethod)
        
        debugPrint("------------- Start -------------");
        print("requestURL :- \(requestURL)");
        
        let escapedString = requestURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        
        let window = AppDelegate.singleton.window?.rootViewController
        var hud : MBProgressHUD
        
        if showLoader && window != nil {
            hud = MBProgressHUD .showAdded(to: window!.view, animated: true)
        } else {
            hud = MBProgressHUD()
        }
        hud.mode = .indeterminate
        hud.label.text = "Loading";
        hud.animationType = .zoomIn
        hud.tintColor = UIColor.black
        hud.contentColor = UIColor.lightGray
        
        //let parameterDict = NSMutableDictionary(dictionary: parameter)
        print("parameter :- \(parameter)");
        
        let manager = apiManager
        
        manager.post(escapedString!, parameters: parameter, constructingBodyWith: {(formData : AFMultipartFormData) in
        
            for imgObject in images {
                
                let imgData = UIImageJPEGRepresentation(imgObject, 0.9)
                if imgData != nil {
                    formData.appendPart(withFileData: imgData!, name: name, fileName: "image.jpeg", mimeType: "image/jpeg")
                }
            }
            
        }, progress: {( progress : Progress) in
            
        }, success: {(dataTask, response) in
            
            if showLoader {
                hud.hide(animated: true)
            }
            
            if let data = (response as? NSDictionary)?.object(forKey: "response") as? NSDictionary {
                
                print("response :- \(data)");
                
                debugPrint("------------- End -------------");
                
                if (data.value(forKeyPath: "code") as! String) == "200" {
                    successBlock(data)
                } else {
                    failureBlock(data, nil)
                }
                
            } else {
                messageBox(message: self.messageParsingError)
            }
            
        }, failure: { (dataTask, error) in
        
            if showLoader {
                hud.hide(animated: true)
            }
            messageBox(message: error.localizedDescription)
            print("error :- \(error.localizedDescription)");
            debugPrint("------------- End -------------");
            failureBlock(nil, error)
        })
        
    }
    
    //------------------------------------------------------
    
    //MARK: Initialisation
    
    override init() {
        super.init()
        
        //AFNetworkReachabilityManager.shared().startMonitoring()
    }
}

extension String {
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
}

extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}
