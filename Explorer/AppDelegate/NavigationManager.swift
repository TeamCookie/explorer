//
//  NavigationManager.swift
//  Explorer
//
//  Created by Team Cookie on 28/02/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation

enum ScreenType {
    
    case AddChallenge
    case Map
    case MyChallenge
    case CheckIn
    case MyBadges
}

class NavigationManager : NSObject {
    
    static let singleton : NavigationManager = NavigationManager()
    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custom Methods
    
    func screen(screenType : ScreenType) -> UIViewController {
        
        switch screenType {
            
        case .AddChallenge:
            let controller = mainStoryboard.instantiateViewController(withIdentifier: String.className(AddChallengeVC.self)) as! AddChallengeVC
            return controller
        case .Map:
            let controller = mainStoryboard.instantiateViewController(withIdentifier: String.className(MapVC.self)) as! MapVC
            return controller
        case .MyChallenge:
            let controller = mainStoryboard.instantiateViewController(withIdentifier: String.className(MyChallengesVC.self)) as! MyChallengesVC
            return controller
        case .CheckIn:
            let controller = mainStoryboard.instantiateViewController(withIdentifier: String.className(CheckInVC.self)) as! CheckInVC
            return controller
        case .MyBadges:
            let controller = mainStoryboard.instantiateViewController(withIdentifier: String.className(MyBadgesVC.self)) as! MyBadgesVC
            return controller
        }
    }
    
    //------------------------------------------------------
}
