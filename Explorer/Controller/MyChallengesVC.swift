//
//  MyChallengesVC.swift
//  Explorer
//
//  Created by Team Cookie on 02/03/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation

class MyChallengesCell: UITableViewCell {
}

class MyChallengesVC : UIViewController {
    
    @IBOutlet weak var tblMyChallengaes: UITableView!
    
    var locationType : LocationType = .Local
    
    var locals : [MyChallangeModal] = []
    var states : [MyChallangeModal] = []
    var counties : [MyChallangeModal] = []
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action Methods
    
    /*@IBAction func btnEditTapp(_ sender: UIBarButtonItem) {
        
        if sender.title == "Edit" {
            tblMyChallengaes.setEditing(true, animated: true)
            sender.title = "Done"
        } else {
            tblMyChallengaes.setEditing(false, animated: true)
        }
    }*/
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locals = CoreDataManager.singleton.fetchMyChallenges(type: LocationType.Local.rawValue)
        states = CoreDataManager.singleton.fetchMyChallenges(type: LocationType.State.rawValue)
        counties = CoreDataManager.singleton.fetchMyChallenges(type: LocationType.World.rawValue)
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

extension MyChallengesVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return locals.count
        } else if section == 1 {
            return states.count
        } else {
            return counties.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let horizontantalMargin : CGFloat = 10
        let verticalMargin : CGFloat  = 5
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteView = UIView(frame: CGRect(x: horizontantalMargin, y: verticalMargin, width: cell.bounds.size.width - (2 * horizontantalMargin), height: cell.bounds.size.height - (2 * verticalMargin)))
        whiteView.backgroundColor = UIColor(hex: "80DBFF", alpha: 1.0)
        whiteView.layer.masksToBounds = false
        whiteView.layer.cornerRadius = 3.0
        whiteView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteView.layer.shadowOpacity = 0.5
        cell.contentView.addSubview(whiteView)
        cell.contentView.sendSubview(toBack: whiteView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(MyChallengesCell.self)) as! MyChallengesCell
        let desclosure = UIImageView(image: #imageLiteral(resourceName: "arrow-point-to-right"))
        cell.accessoryView = desclosure
        
        if indexPath.section == 0 {
            
            let result = locals[indexPath.row]
            cell.textLabel?.text = result.name
            let distance = Double(result.distance ?? "0")!/1609.34
            cell.detailTextLabel?.text = String("Distance : ")?.appending(String(distance).appending(String(" miles")))
            
        } else if (indexPath.section == 1) {
            
            let result = states[indexPath.row]
            cell.textLabel?.text = result.name
            cell.detailTextLabel?.text = ""
        } else {
            
            let result = counties[indexPath.row]
            cell.textLabel?.text = result.name
            cell.detailTextLabel?.text = ""
        }
        
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
    }
}

extension MyChallengesVC : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    /*func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle(rawValue: 3)!
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        var result : MyChallangeModal! = MyChallangeModal(fromDictionary: [:])
        
        if indexPath.section == 0 {
            result = locals[indexPath.row]
        } else if (indexPath.section == 1) {
            result = states[indexPath.row]
        } else {
            result = counties[indexPath.row]
        }
       
        let controller = NavigationManager.singleton.screen(screenType: ScreenType.CheckIn) as! CheckInVC
        controller.myChallange = result
        _ = navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return LocationType.Local.rawValue
        } else if  section == 1 {
            return LocationType.State.rawValue
        } else {
            return LocationType.World.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 && locals.count == 0 {
              return 60
        }
        
        if section == 1 && states.count == 0 {
              return 60
        }
        
        if section == 2 && counties.count == 0 {
              return 60
        }
        
        return 0
    }       
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        var result : MyChallangeModal! = MyChallangeModal(fromDictionary: [:])
        
        if indexPath.section == 0 {
            result = locals[indexPath.row]
        } else if (indexPath.section == 1) {
            result = states[indexPath.row]
        } else {
            result = counties[indexPath.row]
        }
        
        if CoreDataManager.singleton.delete(myChallange: result) == true {
           
            if indexPath.section == 0 {
                
                if let index = locals.index(of: result) {
                    locals.remove(at: index)
                }
                
            } else if (indexPath.section == 1) {
               
                if let index = states.index(of: result) {
                    states.remove(at: index)
                }
            } else {
                
                if let index = counties.index(of: result) {
                    counties.remove(at: index)
                }
            }
            tblMyChallengaes.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 && locals.count == 0 {
           
            let footerText = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenRect.width, height: 60))
            footerText.textColor = UIColor.darkGray
            footerText.text = "No record found"
            footerText.textAlignment = .center
            return footerText
        }
        
        if section == 1 && states.count == 0 {
           
            let footerText = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenRect.width, height: 60))
            footerText.textColor = UIColor.darkGray
            footerText.text = "No record found"
            footerText.textAlignment = .center
            return footerText
        }
        
        if section == 2 && counties.count == 0 {
            let footerText = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenRect.width, height: 60))
            footerText.textColor = UIColor.darkGray
            footerText.text = "No record found"
            footerText.textAlignment = .center
            return footerText
        }
        
        return nil
    }
}
