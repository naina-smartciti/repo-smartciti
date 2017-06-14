//
//  AccountDetailsViewController.swift
//  SmartCiti
//
//  Created by Sathish on 25/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire

class AccountDetailsViewController: UIViewController {

    @IBOutlet var accountDetailsTableView: UITableView!
    
    let items = ["Profile", "Change Password", "Clear Favories or Recent", "Link Account" ,"Push Notification", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "nav-arrow"), style: .done, target: self, action: #selector(backAction))
        leftBarButton.tintColor = UIColor.black
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Account Details"
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        accountDetailsTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension AccountDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountDetailsTableCell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0{
            print("profile")
        }
        
        if indexPath.section == 0 && indexPath.row == 1{
            print("Change passsword")
            let changePasswordVC = self.storyboard?.instantiateViewController(withIdentifier: Constants().kChangePassword)
            self.navigationController?.pushViewController(changePasswordVC!, animated: true)
        }
        
        if indexPath.section == 0 && indexPath.row == 2{
            print("Clear favorite and recent")
        }
        
        if indexPath.section == 0 && indexPath.row == 3{
            print("Link Account")
        }
        
        if indexPath.section == 0 && indexPath.row == 4{
            print("Push Notificaiton")
        }
        
        if indexPath.section == 0 && indexPath.row == 5{
            print("LogOut")
            
            let params: Parameters = ["": ""]
            let header: HTTPHeaders = ["Authorization": "bearer \(UserDefaults.standard.value(forKey: "accessToken"))"]
            
            ServiceManager.sharedInstance.executeGetURL(url: "http://35.167.31.23:8080/smartcity/oauth/token/revoke", params: params, view: self.view, completion: {
                response in
                
                if response.result.isSuccess {
                    print("Logout success")
                } else if response.result.isFailure {
                    print("Failure")
                }
            })
        }
    }
}
