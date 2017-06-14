//
//  CommunityViewController.swift
//  SmartCiti
//
//  Created by Sathish on 08/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {

    @IBOutlet var communityContainerView: UIView!
    @IBOutlet var notificationContainerView: UIView!
    @IBOutlet var settingContainerView: UIView!
    @IBOutlet var communityBlueLabel: UILabel!
    @IBOutlet var notificationBlueLabel: UILabel!
    @IBOutlet var settingsBlueLabel: UILabel!
    @IBOutlet var notificationSettingLable: UILabel!
    @IBOutlet var communityNotificationLabel: UILabel!
    @IBOutlet var communityButton: UIButton!
    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationContainerView.isHidden = true
        settingContainerView.isHidden = true
        communityContainerView.isHidden = false
        
        communityButton.tintColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        communityBlueLabel.tintColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        
        
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        
        notificationContainerView.isHidden = true
        communityContainerView.isHidden = true
        settingContainerView.isHidden = false
        
        settingButton.tintColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        settingsBlueLabel.tintColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        
        notificationBlueLabel.tintColor = UIColor.white
        communityBlueLabel.tintColor = UIColor.white
        
        
//        let value = SettingViewController()
//        value.tableView.reloadData()
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let filterVC = storyBoard.instantiateViewController(withIdentifier: Constants().kSettingSB)
//        self.navigationController?.pushViewController(filterVC, animated: true)
//        self.view = SettingViewController().view
    }

    @IBAction func notificationAction(_ sender: UIButton) {
        
        communityContainerView.isHidden = true
        settingContainerView.isHidden = true
        notificationContainerView.isHidden = false
        
        notificationBlueLabel.tintColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        
        settingsBlueLabel.tintColor = UIColor.white
        communityBlueLabel.tintColor = UIColor.white
    }
    @IBAction func communityAction(_ sender: UIButton) {
        settingContainerView.isHidden = true
        notificationContainerView.isHidden = true
        communityContainerView.isHidden = false
        
        communityBlueLabel.tintColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        
        notificationBlueLabel.tintColor = UIColor.white
        settingsBlueLabel.tintColor = UIColor.white
    }
}
