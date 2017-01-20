//
//  MyBadgesDelegateProtocol.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit

protocol MyBadgesDelegateProtocol: class{
    func newChallengeButtonPressed(by controller: MyBadgesTableViewController)
    func homeFromBadgeButtonPressed(by controller: MyBadgesTableViewController)
}
