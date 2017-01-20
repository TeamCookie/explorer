//
//  NewChallengeViewController.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class NewChallengeViewController: UIViewController, CLLocationManagerDelegate {
    
    weak var delegate: NewChallengeDelegateProtocol?
    
    // LOCATION MANAGER SETUP
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    var currentLongitude: Double!
    var currentLatitude: Double!
    var location: CLLocation!
    
    @IBOutlet weak var challengeTypeInput: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
//        checkCoreLocationPermissionsAndStartUpdate()
    }
    
    @IBOutlet weak var currentLocationMap: GMSMapView!

    // CANCEL TO GO BACK TO TOP VIEW

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.newChallengeCancelButtonPressed(by: self)
    }
    
    // TO CREATE NEW CHALLENGE
    
    @IBAction func startChallengeButtonPressed(_ sender: UIButton) {
        delegate?.challengeSaved(by: self)
    }
    
    // CHECKING USER PERSMISSIONS OF LOCATION MANAGER
    
//    func checkCoreLocationPermissionsAndStartUpdate() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            print("authorization when in use")
//            locationManager.startUpdatingLocation()
//            print("authorized and starting updates")
//        } else if CLLocationManager.authorizationStatus() == .notDetermined {
//            print("not determined")
//            locationManager.requestWhenInUseAuthorization()
//            print("it thinks not determined and ask")
//        } else if CLLocationManager.authorizationStatus() == .restricted {
//            print("unauthorized to use location service")
//        }
//    }
    
    // LOCATION DELEGATE METHODS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last
//        print("Location: \(location)")
        locationManager.stopUpdatingLocation()
        
//        if let thisCoordinate = location {
//            currentCoordinate = location.coordiante
//            
//        }
        currentCoordinate = location.coordinate
        currentLongitude = Double(location.coordinate.longitude)
        currentLatitude = Double(location.coordinate.latitude)
        
        print("location: \(location), current coord: \(currentCoordinate), current longitude \(currentLongitude!), current latitude \(currentLatitude!)")

        // Create a GMSCameraPosition that tells map to display coordinate
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        currentLocationMap = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.title = "Your Location"
        marker.snippet = "Australia"
        marker.map = mapView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

