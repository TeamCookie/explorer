//
//  ViewController.swift
//  explorer
//
//  Created by June Yoshii on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class HomeViewController: UIViewController, NewChallengeDelegateProtocol, MyChallengeDelegateProtocol {
    // REMEMBER TO ADD OTHER DELEGATE PROTCOLS
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // var personLocation: String?

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func challengeSaved(by controller: NewChallengeViewController) {
    }
    
    func newChallengeCancelButtonPressed(by controller: NewChallengeViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func homeFromBadgeButtonPressed(by controller: MyBadgesTableViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func homeFromMyChallengeButtonPressed(by controller: MyChallengeTableViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func giveUpButtonPressed(by controller: MyChallengeTableViewController, challenge: Challenge){
        let deletedChallenge = challenge
        managedObjectContext.delete(deletedChallenge)
        saveData()
        dismiss(animated: true, completion: nil)
    }
    
    func completeChallengeButtonPressed(by controller: MyChallengeTableViewController) {
    }
    
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            }
            catch {
                print("error saving \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newChallenge" {
            let navigationController = segue.destination as! UINavigationController
            let cancelViewController = navigationController.topViewController as! NewChallengeViewController
            cancelViewController.delegate = self
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

