//
//  MyChallengeDelegateProtocol.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit

protocol MyChallengeDelegateProtocol: class{
    func giveUpButtonPressed(by controller: MyChallengeTableViewController, challenge: Challenge)
    func homeFromMyChallengeButtonPressed(by controller: MyChallengeTableViewController)
    func completeChallengeButtonPressed(by controller: MyChallengeTableViewController)
}
