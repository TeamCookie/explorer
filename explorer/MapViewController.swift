//
//  MapViewController.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/20/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapBox: GMSMapView!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 152, longitude: 3, zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)//        mapBox.camera = camera
        view = mapView
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }

    

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapBox.isMyLocationEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
