//
//  SettingViewController.swift
//  SmartCiti
//
//  Created by Sathish on 13/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let section = ["ACCOUNTS", "SUPPORT", "ABOUT"]
    let items = [["Account Detail"], ["Help", "Feedback"], ["Privacy Policy", "Terms", "Credits"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingViewCell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 0 && indexPath.row == 0) {
            print("Account detail")
            let accountDetailsSB = self.storyboard?.instantiateViewController(withIdentifier: Constants().kAccountDetailsSB)
            self.navigationController?.pushViewController(accountDetailsSB!, animated: true)
        }
        
        if(indexPath.section == 1 && indexPath.row == 0) {
            print("Help")
        }
        
        if(indexPath.section == 1 && indexPath.row == 1) {
            print("Feed back")
        }
        
        if(indexPath.section == 2 && indexPath.row == 0) {
            print("Privacy policy")
        }
        
        if(indexPath.section == 2 && indexPath.row == 1) {
            print("Terms")
        }
        
        if indexPath.section == 2 && indexPath.row == 2 {
            print("Credits")
        }
    }
}
