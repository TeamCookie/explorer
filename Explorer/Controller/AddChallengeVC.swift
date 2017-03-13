//
//  LocationsVC.swift
//  Explorer
//
//  Created by Team Cookie on 28/02/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps
import MapKit

class AddChallengeCell: UITableViewCell {
    
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMiles: UILabel!
}

//https://maps.googleapis.com/maps/api/place/search/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&sensor=false&key=<PROJECT KEY GOES HERE>

class AddChallengeVC : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tblPlaces: UITableView!
    @IBOutlet weak var segmentResultType: UISegmentedControl!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var btnMap: UIBarButtonItem!
    @IBOutlet weak var pickerController: UIPickerView!
    @IBOutlet weak var mapContainer: UIView!
    
    @IBOutlet weak var layoutPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddChallenge: UIButton!
    
    var camera: GMSCameraPosition!
    
    var challengeName : String! = ""
    var distance : String! = ""
    var results : [Result]! = []
    var selectedResult : [Result]! = []
    var challengeTypes : [String] = ["Library", "Restaurant", "Nightclub", "Park", "Cafe", "Bar", "Shopping", "Mall", "Bakery", "Store"]
    
    var locationType : LocationType = .Local    
    var geocoder : CLGeocoder = CLGeocoder()
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custom Methods
    
    func requestGetNearByLocationPlaces(distance : String, types : String) {
        
        if LocationManager.singleton.coordinate2D.latitude == 0 &&  LocationManager.singleton.coordinate2D.longitude == 0 {
            messageBox(message: "Your location service seems off!")
            return
        }
        
        var parameters : Dictionary<String, String>
        
        var location = String(LocationManager.singleton.coordinate2D.latitude).appending(",").appending(String(LocationManager.singleton.coordinate2D.longitude))
        
        var requestMethod : String
        
        if locationType.rawValue == LocationType.World.rawValue {
            
            /*let random = String(arc4random_uniform(20000) + 30000)

            let randomLatitude : Double = Double(arc4random() / 100000000)
            let randomLongitude : Double = Double(arc4random() /  100000000)
            
            location = String(randomLatitude).appending(",").appending(String(randomLongitude))*/
            
            let randomIndex = Int(arc4random_uniform(UInt32(AppDelegate.singleton.countries.count)))
            let randomCountry = AppDelegate.singleton.countries[randomIndex]
            
            AppDelegate.singleton.showLoader()
            
            geocoder .geocodeAddressString(randomCountry, completionHandler: { (placeMark : [CLPlacemark]?, error : Error?) in
                
                guard placeMark?.first != nil else {
                    AppDelegate.singleton.hideLoader()
                    return
                }
                
                let rLocation = placeMark?.first?.location?.coordinate
                
                location = String(describing: rLocation!.latitude).appending(",").appending(String(describing: rLocation!.longitude))
                
                let parameters = ["location" : location,
                              "radius" : distance,
                              "sensor" : "false",
                              "key" : kGoogleAPIKey]
                
                RequestManager.singleton.requestGET(requestMethod: kAPIGooglePlaceSearch, parameters: parameters as [String : AnyObject], showLoader: false, successBlock: { (response : NSDictionary) in
                    
                    AppDelegate.singleton.hideLoader()
                    
                    LocationManager.singleton.stopMonitoring()
                    let placeModal = GooglePlaceModal(fromDictionary: response)
                    self.results = placeModal.results
                    
                    AppDelegate.singleton.selectedResult = self.results
                    if self.locationType.rawValue != LocationType.Local.rawValue {
                        self.selectedResult = self.results
                    }
                    
                    self.tblPlaces.reloadData()
                    
                    if self.results.count == 0 {
                        self.btnMap.isEnabled = false
                    } else {
                        self.btnMap.isEnabled = true
                    }
                    
                    MyNotificationCenter.post(name: NSNotification.Name(rawValue: "NotificationGoogleMap"), object: nil)
                    
                }) { (response : NSDictionary?, error : Error?) in
                    
                    AppDelegate.singleton.hideLoader()
                }
            })
            
            
        } else if (locationType.rawValue == LocationType.State.rawValue ) {
            
            /*let random = String(arc4random_uniform(20000) + 10000)
            
            let randomLatitude : Double = Double(arc4random_uniform(20000) / 10000) + LocationManager.singleton.coordinate2D.latitude
            let randomLongitude : Double = Double(arc4random_uniform(20000) / 10000) + LocationManager.singleton.coordinate2D.longitude
            
            location = String(randomLatitude).appending(",").appending(String(randomLongitude))*/
            
            let randomIndex = Int(arc4random_uniform(UInt32(AppDelegate.singleton.statesUS.count)))
            let randomState = AppDelegate.singleton.statesUS[randomIndex]
            
            geocoder .geocodeAddressString(randomState, completionHandler: { (placeMark : [CLPlacemark]?, error : Error?) in
                
                guard placeMark?.first != nil else {
                    
                    AppDelegate.singleton.hideLoader()
                    return
                }
                
                let rLocation = placeMark?.first?.location?.coordinate
                
                location = String(describing: rLocation!.latitude).appending(",").appending(String(describing: rLocation!.longitude))
                
                let parameters = ["location" : location,
                                  "radius" : distance,
                                  "sensor" : "false",
                                  "key" : kGoogleAPIKey]
                
                AppDelegate.singleton.showLoader()
                
                RequestManager.singleton.requestGET(requestMethod: kAPIGooglePlaceSearch, parameters: parameters as [String : AnyObject], showLoader: false, successBlock: { (response : NSDictionary) in
                    
                    AppDelegate.singleton.hideLoader()
                    
                    LocationManager.singleton.stopMonitoring()
                    let placeModal = GooglePlaceModal(fromDictionary: response)
                    self.results = placeModal.results
                    
                    AppDelegate.singleton.selectedResult = self.results
                    if self.locationType.rawValue != LocationType.Local.rawValue {
                        self.selectedResult = self.results
                    }
                    
                    self.tblPlaces.reloadData()
                    
                    if self.results.count == 0 {
                        self.btnMap.isEnabled = false
                    } else {
                        self.btnMap.isEnabled = true
                    }
                    
                    MyNotificationCenter.post(name: NSNotification.Name(rawValue: "NotificationGoogleMap"), object: nil)
                    
                }) { (response : NSDictionary?, error : Error?) in
                    
                    AppDelegate.singleton.hideLoader()
                }
            })
            
        } else {
            
            requestMethod = kAPIGooglePlaceSearch
            parameters = ["location" : location,
                          "radius" : distance,
                          "sensor" : "false",
                          "key" : kGoogleAPIKey,
                          "keyword" : types]
            
            
            AppDelegate.singleton.showLoader()
            
            RequestManager.singleton.requestGET(requestMethod: requestMethod, parameters: parameters as [String : AnyObject], showLoader: false, successBlock: { (response : NSDictionary) in
                
                AppDelegate.singleton.hideLoader()
                
                LocationManager.singleton.stopMonitoring()
                let placeModal = GooglePlaceModal(fromDictionary: response)
                self.results = placeModal.results
                
                AppDelegate.singleton.selectedResult = self.results
                if self.locationType.rawValue != LocationType.Local.rawValue {
                    self.selectedResult = self.results
                }
                
                self.tblPlaces.reloadData()
                
                if self.results.count == 0 {
                    self.btnMap.isEnabled = false
                } else {
                    self.btnMap.isEnabled = true
                }
                
                MyNotificationCenter.post(name: NSNotification.Name(rawValue: "NotificationGoogleMap"), object: nil)
                
            }) { (response : NSDictionary?, error : Error?) in
                
                AppDelegate.singleton.hideLoader()
            }
        }
        
    }
    
    func getChangeDetails() {
        
        let message = "Please enter new challenge details"
        
        var isFilledName : Bool = false
        var isFilledDistance : Bool = false
        
        let alertController = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        
        let actionAdd = UIAlertAction(title: "Add", style: .default, handler: {
            alert -> Void in
            
            let txtName = alertController.textFields![0] as UITextField
            self.challengeName = txtName.text
            
            /*if self.locationType.rawValue == LocationType.Local.rawValue {
                
                let txtDistance = alertController.textFields![1] as UITextField
                let distInMiles = Double(txtDistance.text ?? "0")
                self.distance = String(distInMiles! * 1609.34)
            }*/
            
            let txtDistance = alertController.textFields![1] as UITextField
            let distInMiles = Double(txtDistance.text ?? "0")
            self.distance = String(distInMiles! * 1609.34)
            
            self.requestGetNearByLocationPlaces(distance: self.distance, types: self.challengeTypes[0])
        })
        
        actionAdd.isEnabled = false
        alertController.addAction(actionAdd)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            alert -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.keyboardType = .alphabet
            textField.placeholder = "Challenge Name"
            
            MyNotificationCenter.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
                
                isFilledName = (textField.text!.length > 0) ? true : false
                

                if isFilledName == true && isFilledDistance {
                    actionAdd.isEnabled = true
                } else {
                    
                    actionAdd.isEnabled = false
                }
                
                /*
                if self.locationType == .State
                {
                    actionAdd.isEnabled = true
                    self.distance = String(10 * 1609.34)
                    
                //    self.requestGetNearByLocationPlaces(distance: self.distance, types: "Restaurant")
                }
                
                if self.locationType == .World
                {
                    actionAdd.isEnabled = true
                    self.distance = String(200 * 1609.34)
                    
                //    self.requestGetNearByLocationPlaces(distance: self.distance, types: "Cafe")
                }
                */
                
                /*if self.locationType.rawValue == LocationType.Local.rawValue {
                    
                    if isFilledName == true && isFilledDistance {
                        actionAdd.isEnabled = true
                    } else {
                        actionAdd.isEnabled = false
                    }
                } else {
                    
                    if isFilledName == true {
                        actionAdd.isEnabled = true
                    } else {
                        actionAdd.isEnabled = false
                    }
                }*/
            }
        })
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.keyboardType = .numberPad
            
            textField.placeholder = "Distance in miles"
            
            MyNotificationCenter.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
                
                isFilledDistance = (textField.text!.length > 0) ? true : false
                
                if isFilledName == true && isFilledDistance {
                    actionAdd.isEnabled = true
                } else {
                    actionAdd.isEnabled = false
                }
            }
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showMap(show : Bool) {
        
        if show == true {
            mapContainer.isHidden = false
            tblPlaces.isHidden = true
            btnMap.title = "List"
        } else {
            mapContainer.isHidden = true
            tblPlaces.isHidden = false
            btnMap.title = "Map"
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Action Methods
    
    @IBAction func segmentValueDidChange(_ sender: UISegmentedControl) {
        
        //self.requestGetNearByLocationPlaces(distance: self.distance)
    }
    
    @IBAction func btnMapTap(_ sender: UIBarButtonItem) {
        
        /*let controller = NavigationManager.singleton.screen(screenType: ScreenType.Map) as! MapVC
        _ = navigationController?.pushViewController(controller, animated: true)*/
        
        if btnMap.title == "List" {
            showMap(show: false)
        } else {
            showMap(show: true)
        }
    }
    
    @IBAction func btnAddChallengeTap(_ sender: UIButton) {
        
        if selectedResult.count < 10 {
            messageBox(message: "Please select at least 10 places to add challenge")
            return
        }
        
        let dataResut = NSKeyedArchiver.archivedData(withRootObject: selectedResult)
       
        var dictionary : Dictionary<String, AnyObject> = [keyId : Date.timeIntervalSinceReferenceDate as AnyObject, keyName :  self.challengeName as AnyObject, keyDistance : self.distance as AnyObject,keyResult : dataResut as AnyObject]
        
        /*if(Double(self.distance)! < 3000) {
            dictionary[keyType] = LocationType.Local.rawValue as AnyObject?
        } else if (Double(self.distance)! >= 3000) && (Double(self.distance)! <= 10000) {
            dictionary[keyType] = LocationType.State.rawValue as AnyObject?
        } else {
            dictionary[keyType] = LocationType.World.rawValue as AnyObject?
        }*/
        dictionary[keyType] = locationType.rawValue as AnyObject?
        
        let myChallange = MyChallangeModal(fromDictionary: dictionary as NSDictionary)
        CoreDataManager.singleton.saveNewChallange(myChallange: myChallange)
        messageBox(message: self.challengeName.appending(" ").appending("created successfully!"))
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return challengeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int
        ) -> String? {
        return challengeTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.requestGetNearByLocationPlaces(distance: self.distance, types: challengeTypes[row])
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMap(show: true)
        LocationManager.singleton.startMonitoring()
        
        if locationType.rawValue == LocationType.World.rawValue || locationType.rawValue == LocationType.State.rawValue {
            
            title = locationType.rawValue
            
            layoutPickerHeight.constant = 0
            pickerController.isHidden = true
            tblPlaces.isEditing = false
            
        } else {
            
            layoutPickerHeight.constant = 216
            pickerController.isHidden = false
            tblPlaces.isEditing = true
        }
        
        getChangeDetails()
        pickerController.delegate = self
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension AddChallengeVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(AddChallengeCell.self)) as! AddChallengeCell
        let result = results[indexPath.row]
        cell.lblName?.text = result.name
        let imgURL = URL(string: result.icon)
        
        if imgURL != nil {
            cell.imgPlace?.setImageWith(imgURL!, placeholderImage: nil)
            cell.layoutSubviews()
        }
        
        let locationDestination = CLLocationCoordinate2D(latitude: Double(result.geometry.location.lat), longitude: Double(result.geometry.location.lng))
        let distanceInMeter = LocationManager.singleton.distanceFromCurrentLocation(destinationCordinate: locationDestination) * 0.000621371
        cell.lblMiles?.text = String(describing: distanceInMeter.roundTo(places: 2)).appending(" Miles")
        
        return cell
    }
}

extension AddChallengeVC : UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let result = results[indexPath.row]
       
        /*if selectedResult.count > 9 {
            tableView.deselectRow(at: indexPath, animated: true)
            messageBox(message: "You can not select more than 10 locations")
            return
        }*/
        
        selectedResult.append(result)
        lblCounter.text = String(selectedResult.count)
        
        /*if selectedResult.count == 0 {
            btnMap.isEnabled = false
        } else {
            btnMap.isEnabled = true
        }*/
        
        //AppDelegate.singleton.selectedResult = selectedResult
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let result = results[indexPath.row]
        
        if selectedResult.contains(result) {
            let index = selectedResult.index(of: result)
            if (index != nil) {
                selectedResult.remove(at: index!)
            }
        }
        lblCounter.text = String(selectedResult.count)
        
        if selectedResult.count == 0 {
            btnMap.isEnabled = false
        } else {
            btnMap.isEnabled = true
        }
        
        //AppDelegate.singleton.selectedResult = selectedResult
    }
}
