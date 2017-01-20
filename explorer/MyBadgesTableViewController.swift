//
//  MyBadgesTableViewController.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import CoreData

class MyBadgesTableViewController: UITableViewController {
    
    var myBadges = [Challenge]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: MyBadgesDelegateProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCompletedChallenges()
    }
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.homeButtonPressed(by: self)
    }
    
    @IBAction func newChallengeButtonPressed(_ sender: UIButton) {
        delegate?.newChallengeButtonPressed(by: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBadges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "badgeCell", for: indexPath)
        cell.textLabel?.text = myBadges[indexPath.row].name
        return cell
    }
    
    func fetchCompletedChallenges()  {
        let badgeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Challenge")

        // TRYING TO FILTER ONLY COMPLETED BADGES
        let filter = "True"
        let predicate = NSPredicate(format: "completed = %@", filter)
        badgeRequest.predicate = predicate
        
        do {
            let results = try managedObjectContext.fetch(badgeRequest)
            myBadges = results as! [Challenge]
        } catch {
            print("\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
