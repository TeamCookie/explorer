//
//  SignInVC.swift
//  Explorer
//
//  Created by Team Cookie on 02/03/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class CheckInCell: UITableViewCell {
    
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMiles: UILabel!
    @IBOutlet weak var btnCheckIn: UIButton!
}

var keyAssociatedCheckIn : Int8 = 0

class CheckInVC : UIViewController {
    
    @IBOutlet weak var tblCheckIns: UITableView!
    
    var myChallange : MyChallangeModal!
    var results : [Result]! = []
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custom Methods
    
    func btnCheckInTap(sender : UIButton) {
        
        let indexPath = objc_getAssociatedObject(sender, &keyAssociatedCheckIn) as? IndexPath
        
        guard indexPath == nil else {
            
            let result = results[indexPath!.row]
            
            let locationDestination = CLLocationCoordinate2D(latitude: Double(result.geometry.location.lat), longitude: Double(result.geometry.location.lng))
            let distanceInMeter = LocationManager.singleton.distanceFromCurrentLocation(destinationCordinate: locationDestination) * 0.000621371
            /*
            if (distanceInMeter.roundTo(places: 2) == 0.00) {
                
                result.isCheckIn = true
                let dataResut = NSKeyedArchiver.archivedData(withRootObject: results)
                myChallange.result = dataResut as NSData!
                CoreDataManager.singleton.updateChallange(myChallange: myChallange)
                results = NSKeyedUnarchiver.unarchiveObject(with: myChallange.result as Data) as! [Result]!
                self.tblCheckIns.reloadData()
                
                messageBox(message: "Congratulation, You have visited this place")
                
            } else {
                
                messageBox(message: "You're not at the place, Please try again")
            }
            */
            result.isCheckIn = true
            let dataResut = NSKeyedArchiver.archivedData(withRootObject: results)
            myChallange.result = dataResut as NSData!
            CoreDataManager.singleton.updateChallange(myChallange: myChallange)
            results = NSKeyedUnarchiver.unarchiveObject(with: myChallange.result as Data) as! [Result]!
            self.tblCheckIns.reloadData()
            
            messageBox(message: "Congratulations, You have visited this place!")

            
            return
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = myChallange.name
        results = NSKeyedUnarchiver.unarchiveObject(with: myChallange.result as Data) as! [Result]!
        LocationManager.singleton.startMonitoring()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        LocationManager.singleton.stopMonitoring()
    }
    
    //------------------------------------------------------
}

extension CheckInVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(CheckInCell.self)) as! CheckInCell
        cell.selectionStyle = .none
        objc_setAssociatedObject(cell.btnCheckIn, &keyAssociatedCheckIn, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let result = results[indexPath.row]
        cell.btnCheckIn.addTarget(self, action: #selector(btnCheckInTap), for: UIControlEvents.touchUpInside)
        cell.lblName?.text = result.name
        let imgURL = URL(string: result.icon)
        
       // cell.lblName.font = cell.lblName.font.withSize(25)
       // cell.lblMiles.font = cell.lblMiles.font.withSize(20)
        if result.isCheckIn != nil && result.isCheckIn == true {
            
            cell.imgPlace?.image = #imageLiteral(resourceName: "visited")
            cell.btnCheckIn.isHidden = true
            
        } else {
            
            cell.btnCheckIn.isHidden = false
            if imgURL != nil {
                cell.imgPlace?.setImageWith(imgURL!, placeholderImage: nil)
                cell.layoutSubviews()
            }
        }
        
        let locationDestination = CLLocationCoordinate2D(latitude: Double(result.geometry.location.lat), longitude: Double(result.geometry.location.lng))
        let distanceInMeter = LocationManager.singleton.distanceFromCurrentLocation(destinationCordinate: locationDestination) * 0.000621371
        cell.lblMiles?.text = String(describing: distanceInMeter.roundTo(places: 2)).appending(" Miles")
        
        return cell
    }
}

extension CheckInVC : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    //    return 60
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
    }
}
