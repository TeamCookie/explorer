//
//  GoogleMapVC.swift
//  Explorer
//
//  Created by Team Cookie on 02/02/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps

protocol GoogleMapDelegate {
    
    func mapDidChange()
    func mapIdleAt(address : String, response : GMSReverseGeocodeResponse)
}

class GoogleMapVC : UIViewController, GMSMapViewDelegate, LocationManagerDelegate {
    
    var delegate : GoogleMapDelegate?
    var mapView: GMSMapView!
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
        MyNotificationCenter.removeObserver(self)
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: LocationManager.singleton.coordinate2D.latitude, longitude:LocationManager.singleton.coordinate2D.longitude, zoom: 8.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        
        mapView.settings.myLocationButton = true
        mapView.setMinZoom(1, maxZoom: 15)
        mapView.delegate = self
        view = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        delegate?.mapDidChange()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
                
        GMSGeocoder().reverseGeocodeCoordinate(position.target) { (response : GMSReverseGeocodeResponse?, error : Error?) in
            
            if error == nil && response != nil {
                let address = response?.firstResult()
                self.delegate?.mapIdleAt(address: (address?.lines?.joined(separator: " ")) ?? "", response: response!)
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: LocationManagerDelegate
    
    func didUpdateLocations(location: CLLocation) {
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    //------------------------------------------------------
    
    //MARK: Notifications
    
    func googleMapListUpdated(notification : Notification) {
        
        // Creates a marker in the center of the map.
        mapView.clear()
        
        var isDisplay : Bool = false
        
        for result in AppDelegate.singleton.selectedResult {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(result.geometry.location.lat), longitude: Double(result.geometry.location.lng))
            marker.title = result.name
            marker.snippet = result.vicinity//result.types.joined(separator: " ")
            marker.map = mapView
            
            if isDisplay == false {
                isDisplay = true
                mapView.camera = GMSCameraPosition.camera(withLatitude: Double(result.geometry.location.lat), longitude:Double(result.geometry.location.lng), zoom: 8.0)
            }
            
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        //mapView.settings.myLocationButton = true
        MyNotificationCenter.addObserver(self, selector: #selector(googleMapListUpdated), name: NSNotification.Name(rawValue: "NotificationGoogleMap"), object: nil)
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //------------------------------------------------------
}

