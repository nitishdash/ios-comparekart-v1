//
//  NewTrackingRequestVC.swift
//  CompareKart-v1
//
//  Created by Nitish Dash on 17/04/17.
//  Copyright © 2017 Nitish Dash. All rights reserved.
//

import UIKit


class NewTrackingRequestVC: UIViewController {
    @IBOutlet weak var dataLabel: UILabel!

    var outMessage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dataLabel.text=outMessage
    
    }
    
    
    
}
