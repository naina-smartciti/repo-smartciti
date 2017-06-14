//
//  SmartMaps-List-ViewController.swift
//  SmartCiti
//
//  Created by Sathish on 22/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class SmartMaps_List_ViewController: UIViewController {

    @IBOutlet var smartMapsTableView: UITableView!
    @IBOutlet var mapListSearchBar: UISearchBar!
    @IBOutlet var searchBarText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smartMapsTableView.allowsSelection = true
        smartMapsTableView.showsVerticalScrollIndicator = false
        searchBarText.layer.cornerRadius = 20
        
//        mapListSearchBar.layer.cornerRadius = 20
//        mapListSearchBar.clipsToBounds = true
//        mapListSearchBar.layer.borderColor = UIColor.white.cgColor
//        mapListSearchBar.layer.borderWidth = 15
//        mapListSearchBar.placeholder = "Search Location"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.isHidden = false
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

extension SmartMaps_List_ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        tableView.register(UINib(nibName: "SmartMapsParkingListCell", bundle: nil), forCellReuseIdentifier: "smartMapsParkingListCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "smartMapsParkingListCell", for: indexPath) as! SmartMapsListTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let parkingDetailSB = storyboard?.instantiateViewController(withIdentifier: "parkingDetailsSB")
//        self.navigationController?.present(parkingDetailSB!, animated: true, completion: nil)
        self.navigationController?.pushViewController(parkingDetailSB!, animated: true)
        
    }
    
}
