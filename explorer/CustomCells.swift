//
//  CustomCells.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit

class BadgeCustomCell: UITableViewCell {
    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var challengeName: UILabel!
    
}

class ChallengePlaceCustomCell: UITableViewCell {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var yesNoCompleteImage: UIImageView!
    @IBOutlet weak var checkInButton: UIButton!
}
