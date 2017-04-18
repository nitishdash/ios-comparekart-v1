//
//  InitialVC.swift
//  CompareKart-v1
//
//  Created by Nitish Dash on 16/04/17.
//  Copyright © 2017 Nitish Dash. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {
    
    @IBOutlet weak var segueButton: UIButton!
    @IBOutlet weak var trackingProductIdTextField: UITextField!
    
    @IBOutlet weak var productIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "priceCheckSegue" {
            let secondViewController:ViewController = segue.destination as! ViewController
            
            secondViewController.outMessage = productIdTextField.text!
        }
        
        if segue.identifier == "trackSegue" {
            let newTrackingVC:NewTrackingRequestVC = segue.destination as! NewTrackingRequestVC
            
            newTrackingVC.outMessage = trackingProductIdTextField.text!
            //            secondViewController.outMessage = textField.text!
        }
        
        
        
    }
    
    
    
    
}
