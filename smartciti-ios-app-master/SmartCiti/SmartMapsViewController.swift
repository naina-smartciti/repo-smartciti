//
//  SmartMapsViewController.swift
//  SmartCiti
//
//  Created by Sathish on 08/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class SmartMapsViewController: UIViewController {

    @IBOutlet var smartMapsMapView: UIView!
    @IBOutlet var smartMapsListView: UIView!
    @IBOutlet var mapListSegmentationController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func mapListSegmentAction(_ sender: UISegmentedControl) {
        
        switch mapListSegmentationController.selectedSegmentIndex {
        case 0:
            self.smartMapsMapView.isHidden = false
            self.smartMapsListView.isHidden = true
        case 1:
            self.smartMapsMapView.isHidden = true
            self.smartMapsListView.isHidden = false
        default:
            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
