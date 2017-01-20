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
import GooglePlaces

class HomeViewController: UIViewController, NewChallengeDelegateProtocol, MyChallengeDelegateProtocol, MyBadgesDelegateProtocol {
    // REMEMBER TO ADD OTHER DELEGATE PROTCOLS
    
    @IBOutlet weak var badgesButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // var personLocation: String?
    var placesClient: GMSPlacesClient!

    override func viewDidLoad() {

        super.viewDidLoad()
//        placesClient = GMSPlacesClient.shared()
//        createPlaces()
        badgesButton.setImage(UIImage(named: "mybadges.png"), for: .normal)
        stateButton.setImage(UIImage(named: "states.png"), for: .normal)
        countryButton.setImage(UIImage(named: "countries.png"), for: .normal)
        challengeButton.setImage(UIImage(named: "mychallenge.png"), for: .normal)
        
//        // CREATE CHALLENGE
//        
//        let newChallenge = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: managedObjectContext) as! Challenge
//        newChallenge.name = ("San Jose Nightlife Challenge")
//        newChallenge.completed = false
//        newChallenge.challengeType = "Nightlife"
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//                print("Success")
//            } catch {
//                print("\(error)")
//            }
//        }


        // CREATING NIGHTLIFE PLACES
//        
//        let bar1 = NSEntityDescription.insertNewObject(forEntityName: "Place", into: managedObjectContext) as! Place
//        bar1.name = "7 Stars Bar & Grill"
//        bar1.visited = false
//        
//        let bar2 = NSEntityDescription.insertNewObject(forEntityName: "Place", into: managedObjectContext) as! Place
//        bar2.name = "Paper Plane"
//        bar1.visited = false
//    
//        let bar3 = NSEntityDescription.insertNewObject(forEntityName: "Place", into: managedObjectContext) as! Place
//        bar3.name = "Haberdasher"
//        bar3.visited = false
//        
//        let bar4 = NSEntityDescription.insertNewObject(forEntityName: "Place", into: managedObjectContext) as! Place
//        bar4.name = "The Escape"
//        bar4.visited = false
//    
//        let bar5 = NSEntityDescription.insertNewObject(forEntityName: "Place", into: managedObjectContext) as! Place
//        bar5.name = "7 Bamboo Lounge"
//        bar5.visited = false
        
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//            } catch {
//                fatalError("Failure to save context: \(error)")
//            }
//        }
//
    }
    
    func challengeSaved(by controller: NewChallengeViewController, challengeType: String) {
//        createChallenge(challengeType: challengeType)
    }
    
    // CREATES NEW CHALLENGE
    
    func createChallenge(challengeType: String){
//        let newChallenge = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: managedObjectContext) as! Challenge
//        newChallenge.name = ("San Jose \(challengeType) Challenge")
//        newChallenge.completed = false
//        newChallenge.challengeType = challengeType
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//                print("Success")
//            } catch {
//                print("\(error)")
//            }
//        }
//    }
//
//    func createPlaces() {
//        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription) \(error)")
//                return
//            }
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                for likelihood in placeLikelihoodList.likelihoods {
//                    let place = likelihood.place
//                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
//                    print("Current Place address \(place.formattedAddress)")
//                    print("Current Place attributions \(place.attributions)")
//                    print("Current PlaceID \(place.placeID)")
//                }
//            }
//        })
    }
    
    func newChallengeCancelButtonPressed(by controller: NewChallengeViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func homeFromBadgeButtonPressed(by controller: MyBadgesTableViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func homeFromMyChallengeButtonPressed(by controller: MyChallengeTableViewController){
        print("coming to home controller to dismiss")
        dismiss(animated: true, completion: nil)
        print("processed dismiss")
    }
    
    func giveUpButtonPressed(by controller: MyChallengeTableViewController, challenge: Challenge){
        let deletedChallenge = challenge
        managedObjectContext.delete(deletedChallenge)
        saveData()
        dismiss(animated: true, completion: nil)
    }
//    
//    func deleteChallenge(){
//        let deletedItem = 
//        do {
//            try managedObjectContext.delete(deletedItem)
//            print("Success")
//        } catch {
//            print("\(error)")
//        }
//    }
    
    func completeChallengeButtonPressed(by controller: MyChallengeTableViewController) {
    }
    
    func newChallengeButtonPressed(by controller: MyBadgesTableViewController) {
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
        } else if segue.identifier == "myBadges" {
            let navigationController = segue.destination as! UINavigationController
            let badgesHomeViewController = navigationController.topViewController as! MyBadgesTableViewController
            badgesHomeViewController.delegate = self
        } else if segue.identifier == "myChallenge" {
            let navigationController = segue.destination as! UINavigationController
            let myChallengeViewController = navigationController.topViewController as! MyChallengeTableViewController
            myChallengeViewController.delegate = self
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

