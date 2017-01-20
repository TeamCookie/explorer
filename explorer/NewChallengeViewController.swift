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
    
    // LOCATION MANAGER SETUP
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
//        didSet {
//            currentCoordinate = location.coordinate
//            currentLongitude = Double(location.coordinate.longitude)
//            currentLatitude = Double(location.coordinate.latitude)
//        }
//    }
    
    @IBOutlet weak var currentLocationMap: GMSMapView!
    @IBOutlet weak var challengeTypeInput: UIPickerView!
    var randomChallengeLocationTypes = ["zoo", "park", "stadium", "natural_feature", "museum", "city_hall", "university", "aquarium", "amusement_park", "night_club", "restaurant"]
//    var outdoorsChallengeLocationTypes = ["zoo", "park", "stadium", "natural_feature"]
//    var historyChallengeLocationTypes = ["museum", "city_hall", "stadium", "university"]
//    var funChallengeLocationTypes = ["aquarium", "amusement_park", "night_club", "restaurant"]
    var typeOfChallengeSelected = String()
    var typeOfChallengePickerOptions: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengeTypeInput.delegate = self
        self.challengeTypeInput.dataSource = self
    
        typeOfChallengePickerOptions = ["Random", "Outdoors", "History", "Fun"]

        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
        // CANCEL TO GO BACK TO TOP VIEW

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.newChallengeCancelButtonPressed(by: self)
    }
    
    // TO CREATE NEW CHALLENGE
    
    @IBAction func startChallengeButtonPressed(_ sender: UIButton) {
        let challengeType = typeOfChallengeSelected
        let coordinate = currentCoordinate!
        delegate?.challengeSaved(by: self, challengeType: challengeType, coordinate: coordinate)
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


        if let location = locations.last {
            print("my latitude \(location.coordinate.latitude)")
            print("my longitude \(location.coordinate.longitude)")
            
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 11.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            self.currentLocationMap = mapView
            self.currentLocationMap.camera = camera

            locationManager.stopUpdatingLocation()

        }
//            print("Location: \(location)")
        
        //        print("location: \(location), current coord: \(currentCoordinate), current longitude \(currentLongitude!), current latitude \(currentLatitude!)")
        
        //         Create a GMSCameraPosition that tells the map to display the
        //         coordinate -33.86,151.20 at zoom level 6.
        
        
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

