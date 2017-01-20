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

class NewChallengeViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: NewChallengeDelegateProtocol?
    
    var camera: GMSCameraPosition!

    @IBOutlet weak var currentLocationMap: GMSMapView!
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    var currentLongitude: Double = 0.0
    var currentLatitude: Double = 0.0
    var location: CLLocation! {
        didSet {
            currentCoordinate = location.coordinate
            currentLongitude = Double(location.coordinate.longitude)
            currentLatitude = Double(location.coordinate.latitude)
        }
    }

    @IBOutlet weak var challengeTypeInput: UIPickerView!
    var randomChallengeLocationTypes = ["Random", "Parks", "Nightlife"]
    var typeOfChallengeSelected = String()
    var typeOfChallengePickerOptions: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengeTypeInput.delegate = self
        self.challengeTypeInput.dataSource = self
    
        typeOfChallengePickerOptions = ["Random", "Parks", "Nightlife"]
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
        // CANCEL TO GO BACK TO TOP VIEW

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.newChallengeCancelButtonPressed(by: self)
    }
    
    // TO CREATE NEW CHALLENGE
    
    @IBAction func startChallengeButtonPressed(_ sender: UIButton) {
        let challengeType = typeOfChallengeSelected
//        let coordinate = currentCoordinate!
        delegate?.challengeSaved(by: self, challengeType: challengeType)
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            self.currentLocationMap.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last
        
        locationManager.stopUpdatingLocation()
        
        camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 11.0)
        
        //         Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.title = "Your Location"
        //        marker.snippet = location.description
        marker.map = currentLocationMap
        
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        self.currentLocationMap.camera = camera
        self.currentLocationMap = mapView
        print(self.currentLocationMap)
        
        self.currentLocationMap.isMyLocationEnabled = true
        
        self.view.addSubview(self.currentLocationMap)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // PICKER PROTOCOL FUNCTIONS
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeOfChallengePickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int
        ) -> String? {
        return typeOfChallengePickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeOfChallengeSelected = typeOfChallengePickerOptions[row]
    }
    
}

