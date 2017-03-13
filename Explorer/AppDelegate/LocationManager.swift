//
//  LocationManager.swift
//  LocationTracking
//
//  Created by Team Cookie on 24/02/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

@objc
protocol LocationManagerDelegate {
    
    func didUpdateLocations(location: CLLocation)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
  
    var delegate : LocationManagerDelegate?
    
    var coordinate2D : CLLocationCoordinate2D! = CLLocationCoordinate2D()
    var isSchedule : Bool = false
    
    static var singleton = LocationManager()
    
    //MARK: Memory Management Method
    
    deinit { //same like dealloc in ObjectiveC
        
    }
   
    //------------------------------------------------------
    
    //MARK: Public
    
    func startMonitoring() {
        locationManager.startUpdatingLocation()
    }
    
    func stopMonitoring() {
        locationManager.stopUpdatingLocation()
    }
    
    func distanceFromCurrentLocation(destinationCordinate : CLLocationCoordinate2D) -> Double {
        
        let locationSource = CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        let locationDestination = CLLocation(latitude: destinationCordinate.latitude, longitude: destinationCordinate.longitude)
        return locationSource.distance(from: locationDestination)
    }       
    
    //------------------------------------------------------
    
    //MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (locations.first != nil) {
            coordinate2D = locations.first!.coordinate
            delegate?.didUpdateLocations(location: locations.first!)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Initialisation
    
    override init() {
        super.init()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    //------------------------------------------------------
}
