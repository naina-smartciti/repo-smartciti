//
//  CreateEventViewController.swift
//  SmartCiti
//
//  Created by Sathish on 08/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let userTypeId = UserDefaults.standard.value(forKey: "userTypeId") as! Int
    var rightButtonTitle: String?
    var navBarTitle: String?
    var cell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        
        
        
        if( userTypeId == 1) {
            rightButtonTitle = "Create Event"
            navBarTitle = "Event"
        } else if (userTypeId == 2) {
            rightButtonTitle = "Create Business"
            navBarTitle = "Business"
        }
        
        self.navigationItem.title = navBarTitle
//        self.navigationItem.rightBarButtonItem?.title = rightButtonTitle
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "create-active")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @IBAction func createBusinessAction(_ sender: UIBarButtonItem) {
        
        
        if(userTypeId == 1){
            let createBusinessSB = self.storyboard?.instantiateViewController(withIdentifier: "createEventFormSB")
            self.navigationController?.pushViewController(createBusinessSB!, animated: true)
        } else if(userTypeId == 2) {
            let createBusinessSB = self.storyboard?.instantiateViewController(withIdentifier: "createBusiness")
            self.navigationController?.pushViewController(createBusinessSB!, animated: true)
        }
    }
    

}

extension CreateEventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.userTypeId == 1) {
            
            tableView.register(UINib(nibName: "CreateEventTableCell", bundle: nil), forCellReuseIdentifier: "createEventTableCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "createEventTableCell", for: indexPath)
            cell?.selectionStyle = .none
            
            return cell!
            
        } else if(self.userTypeId == 2) {
            
            tableView.register(UINib(nibName: "CreateBusinessTableCell", bundle: nil), forCellReuseIdentifier: "createBusinessTableCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "createBusinessTableCell", for: indexPath)
            cell?.selectionStyle = .none
            return cell!
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.userTypeId == 1) {
            
            let parkingDetailSB = storyboard?.instantiateViewController(withIdentifier: "eventDetailSB")
            self.navigationController?.pushViewController(parkingDetailSB!, animated: true)
            print("personal user table select")
            
        } else if(self.userTypeId == 2) {
            
            let parkingDetailSB = storyboard?.instantiateViewController(withIdentifier: "businessDetailSB")
            self.navigationController?.pushViewController(parkingDetailSB!, animated: true)
            print("business user table select")
            
        }
    }
}
