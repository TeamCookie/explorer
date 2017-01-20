//
//  NewChallengeViewController.swift
//  explorer
//
//  Created by Stefanie Fluin on 1/19/17.
//  Copyright © 2017 juney. All rights reserved.
//

import UIKit
import CoreLocation

class NewChallengeViewController: UIViewController {
    
    weak var delegate: NewChallengeDelegateProtocol?
    @IBOutlet weak var challengeTypeInput: UIPickerView!
    @IBOutlet weak var cityInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    @IBAction func startChallengeButtonPressed(_ sender: UIButton) {
        delegate?.challengeSaved(by: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

