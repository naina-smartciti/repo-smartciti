//
//  HomeViewController.swift
//  SmartCiti
//
//  Created by Sathish on 08/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
//        self.collectionView.bounces = false
        
//        self.collectionView.showsHorizontalScrollIndicator = false
//        self.collectionView.showsVerticalScrollIndicator = false
        let imageView: UIView = Bundle.main.loadNibNamed("imageSliderHome", owner: self, options: nil)?.first as! UIView
        //let headerImageSlider = UINib(nibName: "imageSliderHome", bundle: nil)
        
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorColor = UIColor.gray
        self.tableView.tableHeaderView = imageView
        
        navigationBarCustomCode()
        tabBarCustomCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func weatherApiAction() {
        
    }
    
    func sortBarButtonAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let moreLikeAction = UIAlertAction(title: "Most Liked", style: .default, handler: nil)
        let whatsNewAction = UIAlertAction(title: "What's New", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(moreLikeAction)
        alert.addAction(whatsNewAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigationBarCustomCode() {
        
        let sortBarButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortBarButtonAction))
        sortBarButton.tintColor = UIColor.black
        
        var weatherImage = UIImage.init(named: "weather")
        weatherImage = weatherImage?.withRenderingMode(.alwaysOriginal)
        let weatherBarButton = UIBarButtonItem(image: UIImage(named: "weather"), style: .plain, target: self, action: #selector(weatherApiAction))
        weatherBarButton.image = weatherImage
        
        self.navigationItem.rightBarButtonItems = [sortBarButton, weatherBarButton]
    }
    
    func tabBarCustomCode() {
        
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "houston-1")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "smartmap")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].image = UIImage(named: "create")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[3].image = UIImage(named: "favorites")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[4].image = UIImage(named: "community")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarController?.tabBar.items?[0].selectedImage = UIImage(named: "houston-active")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].selectedImage = UIImage(named: "smartmap-active")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].selectedImage = UIImage(named: "create-active")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[3].selectedImage = UIImage(named: "favorites-active")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[4].selectedImage = UIImage(named: "community-active")?.withRenderingMode(.alwaysOriginal)
    }

    
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let filterVC = storyBoard.instantiateViewController(withIdentifier: Constants().kFilterSB) as! FilterViewController
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //self.locationAccess()
    }
    
    @IBAction func sortAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let moreLikeAction = UIAlertAction(title: "Most Liked", style: .default, handler: nil)
        let whatsNewAction = UIAlertAction(title: "What's New", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(moreLikeAction)
        alert.addAction(whatsNewAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func weatherAPIAction(_ sender: UIBarButtonItem) {
    }
    func locationAccess() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            tableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: Constants().kHomeCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants().kHomeCell, for: indexPath) as! HomeTableViewCell
            cell.dateAndDistanceView.layer.cornerRadius = 15
            return cell
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //collectionView.register(UINib(nibName: "ImageSliderCell", bundle: nil), forCellWithReuseIdentifier: "imageSliderCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath)
        //cell.backgroundColor = UIColor.yellow
        return cell
    }
}
