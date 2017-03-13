//
//  AppDelegate.swift
//  Explorer
//
//  Created by Team Cookie on 28/02/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import AFNetworking
import MBProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var hud : MBProgressHUD!
       
    func showLoader() {
        
        DispatchQueue.main.async {
            
            self.hud = MBProgressHUD.showAdded(to: self.window!, animated: true)
            self.hud.mode = .indeterminate
            self.hud.label.text = "Loading";
            self.hud.animationType = .zoomIn
            self.hud.tintColor = UIColor.lightGray
            self.hud.contentColor = UIColor.darkGray
        }
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async {
            
            self.hud.hide(animated: true, afterDelay: 2.0)
        }
    }
    
    var locationType : LocationType! = LocationType.Local
    var selectedResult : [Result]! = []
    
    lazy var cdstore: CoreDataStore = {
        let cdstore = CoreDataStore()
        return cdstore
    }()
    
    lazy var cdh: CoreDataHelper = {
        let cdh = CoreDataHelper()
        return cdh
    }()
    
    var countries : [String] {
        
        if let path = Bundle.main.path(forResource: "Countries", ofType: "plist") {
            
            let result = NSArray(contentsOfFile: path)?.map({ (iCountry : Any) -> String in
                let country = iCountry as! Dictionary<String, AnyObject>
                return country["name"] as! String
            })
            return result!
        }
        
        return []
    }
    
    var statesUS : [String] {
        
        if let path = Bundle.main.path(forResource: "USState", ofType: "plist") {
            
            let result = NSDictionary(contentsOfFile: path)?.allKeys as! [String]
            return result
        }
        
        return []
    }

    //------------------------------------------------------
    
    //MARK: Singleton
    
    static var singleton : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //------------------------------------------------------
    
    //MARK: AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let locationManager = LocationManager.singleton
        print(locationManager)
        
        GMSServices.provideAPIKey(kGoogleAPIKey)
        GMSPlacesClient.provideAPIKey(kGoogleAPIKey)
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //self.saveContext()
    }
}

