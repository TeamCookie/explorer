//
//  MyBadgesVC.swift
//  Explorer
//
//  Created by Team Cookie on 02/03/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation

class MyBadgesCell : UITableViewCell {
}

class MyBadgesVC : UIViewController {
    
    @IBOutlet weak var tblMyBadges: UITableView!
    
    var results : [MyChallangeModal] = []
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        results = CoreDataManager.singleton.fetchMyBadges()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

extension MyBadgesVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(MyBadgesCell.self)) as! MyBadgesCell
        let result = results[indexPath.row]
        cell.textLabel?.text = result.name
        
        let distance = (Double(result.distance) ?? 1)/1609.34
        cell.detailTextLabel?.text = String("Distance : ")?.appending(String(distance))
        
        if(result.type == LocationType.Local.rawValue) {
            cell.detailTextLabel?.text = "Local Explorer"
            cell.imageView?.image = UIImage(named: "local_explorer.png")
        } else if (result.type == LocationType.State.rawValue) {
            cell.detailTextLabel?.text = "State Explorer"
            cell.imageView?.image = UIImage(named: "state_explorer.jpg")
        } else if (result.type == LocationType.State.rawValue){
            cell.detailTextLabel?.text = "World Explorer"
            cell.imageView?.image = UIImage(named: "world_explorer.jpg")
        }
        else
        {
            cell.detailTextLabel?.text = "Rookie Explorer"
            cell.imageView?.image = UIImage(named: "badge-rookie-sm.png")
        }
        
        
        return cell
    }
}

extension MyBadgesVC : UITableViewDelegate {
    
    
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
        
    }
}
