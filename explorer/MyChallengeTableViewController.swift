//
//  MyChallengeTableViewController.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import CoreData

class MyChallengeTableViewController: UITableViewController {
    
    var myPlaces = [Place]()
    var ChallengesButActuallyJustOne: [Challenge]?
    var thisChallenge: Challenge?
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: MyChallengeDelegateProtocol?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var challengeNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChallengePlaces()
        for challenge in ChallengesButActuallyJustOne! {
            print(challenge.name)
        }
//        print(ChallengesButActuallyJustOne)
        thisChallenge = ChallengesButActuallyJustOne?[0]
        challengeNameLabel.text = "San Jose Nightlife Challenge"
//        challengeNameLabel.text = thisChallenge!.name
        
        // CHECKING THAT PLACES ARE TIED TO CHALLENGE
        
//        print("\(thisChallenge?.name)")
//        let someplacesjoe = thisChallenge?.places
//        for place in myPlaces {
//            print(place.name)
//        }
        
        // ADDING RELATIONSHIP FROM PLACES TO CHALLENGE
        
//        for place in myPlaces {
//            thisChallenge?.addToPlaces(place)
//        }
//        
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//                print("place saved to challenge")
//            } catch {
//                fatalError("Failure to save context: \(error)")
//            }
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeCell") as! ChallengePlaceCustomCell
        let thisPlace = myPlaces[indexPath.row]
        cell.placeName.text = thisPlace.name
        if thisPlace.visited == true {
            cell.yesNoCompleteImage.image = UIImage(named: "visited")
            cell.checkInButton.isHidden = true
        } else if thisPlace.visited == false {
            cell.yesNoCompleteImage.image = UIImage(named: "notvisited")
        }
        return cell
    }
    
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        print("button clicked")
        delegate?.homeFromMyChallengeButtonPressed(by: self)
        if let thisDelegate = delegate {
            print(thisDelegate)
        } else {
            print("no delegate")
        }
    }
    
    @IBAction func giveUpButtonPressed(_ sender: UIBarButtonItem, challenge: Challenge) {
        delegate?.giveUpButtonPressed(by: self, challenge: thisChallenge!)
    }
    
    
    @IBAction func checkInButtonPressed(_ sender: UIButton) {
        let cell = sender.superview?.superview as! ChallengePlaceCustomCell
        let indexPath = tableView.indexPath(for: cell)
        print(indexPath)
        let visitedPlace = myPlaces[(indexPath?.row)!]
        visitedPlace.visited = true
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("place saved to challenge")
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        
        cell.yesNoCompleteImage.image = UIImage(named: "visited")
        
        fetchChallengePlaces()
        tableView.reloadData()
        
    }
    
    @IBAction func completeChallengeButtonPressed(_ sender: UIButton) {
        delegate?.completeChallengeButtonPressed(by: self)
    }
    
    // FETCH DATA
    
    func fetchChallengePlaces()  {
        let thisChallengeRequests = NSFetchRequest<NSFetchRequestResult>(entityName: "Challenge")
//        thisChallengeRequests.predicate = NSPredicate(format: "completed == false")

        do {
            let results = try managedObjectContext.fetch(thisChallengeRequests)
            ChallengesButActuallyJustOne = results as! [Challenge]
        } catch {
            print("\(error)")
        }
    
    // FETCHING PLACES OF CHALLENGE
        
        let placesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
//        placesRequest.predicate = NSPredicate(format: "ANY challenge.name in %&", thisChallenge!)
        do {
            let results2 = try managedObjectContext.fetch(placesRequest)
            myPlaces = results2 as! [Place]
        } catch {
            print("\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
