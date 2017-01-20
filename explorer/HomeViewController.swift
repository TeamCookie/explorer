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

    }
    
    func challengeSaved(by controller: NewChallengeViewController, challengeType: String, coordinate: CLLocationCoordinate2D) {
//        createChallenge(challengeType: challengeType)
    }
    
    // CREATES NEW CHALLENGE
    
    func createChallenge(challengeType: String){
        let newChallenge = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: managedObjectContext) as! Challenge
        newChallenge.name = ("San Jose \(challengeType) Challenge")
        newChallenge.completed = false
        newChallenge.challengeType = challengeType
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
    }
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
//    }
    
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
//        } else if segue.identifier == "newChallengeFromBadge" {
//            let navigationController = segue.destination as! UINavigationController
//            let badgesNewChallengeViewController = navigationController.topViewController as! MyBadgesTableViewController
//            badgesNewChallengeViewController.delegate = self
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

