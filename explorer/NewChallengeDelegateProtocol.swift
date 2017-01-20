//
//  NewChallengeDelegateProtocol.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit

protocol NewChallengeDelegateProtocol: class{
    func challengeSaved(by controller: NewChallengeViewController)
    func cancelButtonPressed(by controller: NewChallengeViewController)
}
