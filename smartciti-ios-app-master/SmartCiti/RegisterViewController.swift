//
//  RegisterViewController.swift
//  SmartCiti
//
//  Created by Sathish on 07/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var backNavBarOutlet: UIBarButtonItem!
    @IBOutlet var segmentationOutlet: UISegmentedControl!
    @IBOutlet var personalView: UIView!
    @IBOutlet var businessView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide navigation bar
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func personalBusinessSegmentationAction(_ sender: UISegmentedControl) {
        switch segmentationOutlet.selectedSegmentIndex {
        case 0:
            personalView.isHidden = false
            businessView.isHidden = true
            self.viewDidLoad()
        case 1:
            personalView.isHidden = true
            businessView.isHidden = false
            self.viewDidLoad()
        default:
            break
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
