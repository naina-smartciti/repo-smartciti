//
//  HourseOfOperationShareView.swift
//  SmartCiti
//
//  Created by Sathish on 25/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class HourseOfOperationShareView: UIViewController {

    @IBOutlet var shareImageView: UIImageView!
    @IBOutlet var shareLabel: UILabel!
    @IBOutlet var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 10
        
    }

    @IBAction func facebookAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func instagramAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func twitterAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
