//
//  NewChallengeDelegateProtocol.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

protocol NewChallengeDelegateProtocol: class{
    func challengeSaved(by controller: NewChallengeViewController, challengeType: String, coordinate: CLLocationCoordinate2D)
    func newChallengeCancelButtonPressed(by controller: NewChallengeViewController)
}
