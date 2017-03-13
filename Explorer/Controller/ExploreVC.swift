//
//  ExploreVC.swift
//  Explorer
//
//  Created by Team Cookie on 28/02/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation

class ExploreCell: UICollectionViewCell {

    @IBOutlet weak var imgExplore: UIImageView!
    @IBOutlet weak var lblExplore: UILabel!
}

class ExplorerVC : UIViewController {
    
    @IBOutlet weak var collectionExplore: UICollectionView!
    
    let exploreNames = ["Country", "My Challenges", "State", "My Badges"]
    let exploreImages = ["Explore0", "Explore1", "Explore2", "Explore3"]
    let space : CGFloat = 25.0
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action Methods
    
    @IBAction func btnAddTap(_ sender: UIBarButtonItem) {
        
        let controller = NavigationManager.singleton.screen(screenType: ScreenType.AddChallenge) as! AddChallengeVC
        controller.locationType = .Local
        _ = navigationController?.pushViewController(controller, animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertController = UIAlertController(title: "Random Explorer", message: "Click + to add a Local challenge", preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
            // Put your code here
            
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

extension ExplorerVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.className(ExploreCell.self), for: indexPath) as! ExploreCell
        cell.lblExplore.text = exploreNames[indexPath.row]
        cell.imgExplore.image = UIImage(named: exploreImages[indexPath.row])
        
        return cell;
    }
}

extension ExplorerVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (ScreenRect.width/2.0) - (space * 2), height: (ScreenRect.height / 2) - space - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            /*let controller = NavigationManager.singleton.screen(screenType: ScreenType.MyChallenge) as! MyChallengesVC
            controller.locationType = .World
            navigationController?.pushViewController(controller, animated: true)*/
            
            let controller = NavigationManager.singleton.screen(screenType: ScreenType.AddChallenge) as! AddChallengeVC
            controller.locationType = .World
            _ = navigationController?.pushViewController(controller, animated: true)
        }
        
        if indexPath.row == 1 { // My Challenges
            
            let controller = NavigationManager.singleton.screen(screenType: ScreenType.MyChallenge) as! MyChallengesVC
            controller.locationType = .Local
            navigationController?.pushViewController(controller, animated: true)
        }
        
        if indexPath.row == 2 {
            
            /*let controller = NavigationManager.singleton.screen(screenType: ScreenType.MyChallenge) as! MyChallengesVC
            controller.locationType = .State
            navigationController?.pushViewController(controller, animated: true)*/
            
            let controller = NavigationManager.singleton.screen(screenType: ScreenType.AddChallenge) as! AddChallengeVC
            controller.locationType = .State
            _ = navigationController?.pushViewController(controller, animated: true)
        }
        
        if indexPath.row == 3 { // My Badges
            
            let controller = NavigationManager.singleton.screen(screenType: ScreenType.MyBadges)
            navigationController?.pushViewController(controller, animated: true)
        }

    }
}

