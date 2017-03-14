//
//  CoreDataManager.swift
//  Explorer
//
//  Created by Team Cookie on 02/03/17.
//  Copyright © 2017 Team Cookie. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CoreDataManager : NSObject {
    
    static var singleton = CoreDataManager()
    
    var appDelegate : AppDelegate {
        return AppDelegate.singleton
    }
    
    //------------------------------------------------------
    
    func getAutoIncrementValueForNewChallenge() -> NSInteger {
        
        let moc = appDelegate.cdh.backgroundContext!
        let competitionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String.className(MyChallenges.self))
        var count = try! moc.count(for: competitionsFetch)
        if count == NSNotFound {
            count = 0
        }
        else {
            count = count+1
        }
        return count
    }
    
    func delete(myChallange : MyChallangeModal) -> Bool {
        
        let moc = appDelegate.cdh.backgroundContext!
        
        let competitionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String.className(MyChallenges.self))
        competitionsFetch.predicate = NSPredicate(format: "SELF.id == %ld", myChallange.id)
        competitionsFetch.resultType = .managedObjectResultType
        let deleteReq = NSBatchDeleteRequest(fetchRequest: competitionsFetch)
        
        do {
            try moc.execute(deleteReq)
            return true
            
        } catch let error {
            
            print(error)
            return false
        }
        //appDelegate.cdh.saveContext(moc)
    }
    
    //------------------------------------------------------
    
    func saveNewChallange(myChallange : MyChallangeModal) {

        print(appDelegate.cdstore.applicationDocumentsDirectory)
        
        let moc = appDelegate.cdh.backgroundContext!
        let myChallenge = NSEntityDescription.insertNewObject(forEntityName: String.className(MyChallenges.self), into:moc ) as! MyChallenges
        myChallenge.id = Int64(getAutoIncrementValueForNewChallenge())
        myChallenge.name = myChallange.name
        myChallenge.distance = myChallange.distance
        myChallenge.result = myChallange.result
        myChallenge.type = myChallange.type
        appDelegate.cdh.saveContext(moc)
    }
    
    //------------------------------------------------------
    
    func updateChallange(myChallange : MyChallangeModal) {
        
        print(appDelegate.cdstore.applicationDocumentsDirectory)
        
        let moc = appDelegate.cdh.backgroundContext!
        
        let competitionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String.className(MyChallenges.self))
        competitionsFetch.predicate = NSPredicate(format: "SELF.id == %ld", myChallange.id)
        competitionsFetch.resultType = .managedObjectResultType
        let fetchResult = try! moc.fetch(competitionsFetch) as! [MyChallenges]
        
        if let object = fetchResult.first {
            
            object.name = myChallange.name
            object.distance = myChallange.distance
            object.result = myChallange.result
            
            let tResults = NSKeyedUnarchiver.unarchiveObject(with: myChallange.result as Data) as! [Result]!
            let inObjects = tResults?.filter({ (iResult : Result) -> Bool in
                
                if iResult.isCheckIn != nil && iResult.isCheckIn == true {
                    return false
                } else {
                    return true
                }
            })
            if inObjects?.count == 0 {
                object.isBadge = false //true
            } else {
                object.isBadge = true //false
            }
        }
        appDelegate.cdh.saveContext(moc)
    }
    
    //------------------------------------------------------
    
    func fetchMyChallenges(type : String) -> [MyChallangeModal] {
        
        print(appDelegate.cdstore.applicationDocumentsDirectory)
        
        let moc = appDelegate.cdh.backgroundContext!
        let competitionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String.className(MyChallenges.self))
        competitionsFetch.resultType = .dictionaryResultType
        competitionsFetch.predicate = NSPredicate(format: "SELF.type == %@", type)
        let fetchResult = try! moc.fetch(competitionsFetch)
        var prepareReturn : [MyChallangeModal] = []
        for dictionary in fetchResult {
            let object = MyChallangeModal(fromDictionary: dictionary as! NSDictionary)
            prepareReturn.append(object)
        }
        return prepareReturn
    }
    
    func fetchMyBadges() -> [MyChallangeModal] {
        
        print(appDelegate.cdstore.applicationDocumentsDirectory)
        
        let moc = appDelegate.cdh.backgroundContext!
        let competitionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String.className(MyChallenges.self))
        competitionsFetch.resultType = .dictionaryResultType
        competitionsFetch.predicate = NSPredicate(format: "SELF.isBadge == %ld", 1)
        let fetchResult = try! moc.fetch(competitionsFetch)
        var prepareReturn : [MyChallangeModal] = []
        for dictionary in fetchResult {
            let object = MyChallangeModal(fromDictionary: dictionary as! NSDictionary)
            prepareReturn.append(object)
        }
        return prepareReturn
    }
    
    func fetchMyOtherBadges() -> [MyChallangeModal] {
        
        print(appDelegate.cdstore.applicationDocumentsDirectory)
        
        let moc = appDelegate.cdh.backgroundContext!
        let competitionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String.className(MyChallenges.self))
        competitionsFetch.resultType = .dictionaryResultType
        competitionsFetch.predicate = NSPredicate(format: "SELF.isBadge != %ld", 1)
        let fetchResult = try! moc.fetch(competitionsFetch)
        var prepareReturn : [MyChallangeModal] = []
        for dictionary in fetchResult {
            let object = MyChallangeModal(fromDictionary: dictionary as! NSDictionary)
            prepareReturn.append(object)
        }
        return prepareReturn
    }
}
