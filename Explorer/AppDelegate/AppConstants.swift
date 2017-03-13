//
//  AppConstants.swift
//  Explorer
//
//  Created by Team Cookie on 28/02/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation

let kAppName = "Random Explorer"

enum LocationType : String {
    
    case Local = "Local"
    case State = "State"
    case World = "Country"
//    case Rookie = "Rookie"
}

var BlankView : UIView {
    
    let blankView = UIView()
    blankView.backgroundColor = UIColor.clear
    return blankView
}

var ScreenRect : CGRect {
    return UIScreen.main.bounds
}

var MyNotificationCenter : NotificationCenter {
    return NotificationCenter.default
}

var MyUserDefaults : UserDefaults {
    return UserDefaults.standard
}

func messageBox(message : String!) {
    let av = UIAlertView(title: kAppName, message: message, delegate: nil, cancelButtonTitle: kOk)
    av.show()
}

let kCancel = "Cancel"
let kOk = "Ok"
let kCamera = "Camera"
let kGallery = "Gallery"
let kSettings = "Settings"

let kGoogleAPIKey = "AIzaSyCV2Cic_kisg9FSuHhcd4X4ql4JhfSuKfM"
//let kGoogleAPIKey = "AIzaSyCACiX7ZfZ_RCv8PsAVcqQBz_FOXqHuxIQ"
//let kGoogleAPIKey = "AIzaSyBCj4SnWNooSYKWD5tco6MxJr4K1nJ82sM"
