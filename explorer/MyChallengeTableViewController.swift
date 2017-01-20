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
    var thisChallenge = Challenge()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: MyChallengeDelegateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchChallengePlaces()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeCell", for: indexPath)
        cell.textLabel?.text = myPlaces[indexPath.row].name
        return cell
    }
    
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.homeButtonPressed(by: self)
    }
    
    @IBAction func giveUpButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.giveUpButtonPressed(by: self)
    }
    
    @IBAction func checkInButtonPressed(_ sender: UIButton) {
        delegate?.checkInButtonPressed(by: self)
    }
    
    @IBAction func completeChallengeButtonPressed(_ sender: UIButton) {
        delegate?.completeChallengeButtonPressed(by: self)
    }
    
    // FETCH DATA
    
//    func fetchChallengePlaces()  {
//        let thisChallengeRequests = NSFetchRequest<NSFetchRequestResult>(entityName: "Challenge")
//        do {
//            let results = try managedObjectContext.fetch(thisChallengeRequests)
//            thisChallenge = results as! Challenge
//        } catch {
//            print("\(error)")
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
