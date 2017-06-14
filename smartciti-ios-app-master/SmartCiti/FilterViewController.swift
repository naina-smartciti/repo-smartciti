//
//  FilterViewController.swift
//  SmartCiti
//
//  Created by Sathish on 13/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import UserNotifications
import CoreLocation
import MBProgressHUD

class FilterViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var sliderBar: UISlider!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionFlowLayout: UICollectionViewFlowLayout!


    var locationManager: CLLocationManager!
    var cellCount: [CategoryEntities]? = []
    var categoryName: String?
    var sliderValue: Int? = 25
    var selectedCategory = [Int]()
    var screenSize: CGFont?
    var viewTry: UIView? = UIView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Notificaion permission
        let badgeCount: Int = 0
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            application.registerForRemoteNotifications()
            application.applicationIconBadgeNumber = badgeCount
        } else {
            // Fallback on earlier versions
        }

        // Location access permission
        self.locationAccess()
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "FILTER"
        let nextButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(buttonAction))
        nextButton.tintColor = UIColor(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = nextButton
        
        // Collection View cell spacing
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 2, left: 3, bottom: 0, right: 3)
        width = width - 10
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        filterView()
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func filterView() {
        
        // Get category service call
        let categoryParams: Parameters = ["": ""]
        let categoryHeader: HTTPHeaders = ["Authorization": "bearer \(UserDefaults.standard.value(forKey: "accessToken")!)"]
        
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        ServiceManager.sharedInstance.executeGetObjectURLEncoding(type: CategoryList.self, url: Constants().kBaseURL+Constants().kCategoryList, params: categoryParams, headers: categoryHeader ,view: self.view, completion: {
            response in
            if (response?.result.isSuccess)! {
                //let categoryList = (response?.result.value)!
                let statusCode = response?.result.value?.status?.status
                
                if(statusCode == 200) {
                    self.cellCount = response?.result.value?.categoryEntities
                    loader.hide(animated: true)
                    self.collectionView.reloadData()
                }
                else {
                    print("Check: Filter view controller status code")
                    loader.hide(animated: true)
                }
            } else if (response?.result.isFailure)! {
                print("Check: Filter view controller response Failure")
                loader.hide(animated: true)
            }
        })
    }
    
    func locationAccess() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func buttonAction() {
       
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: Constants().kTabBarSB) as! TabBarViewController
        present(homeVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func distanceSliderAction(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        distanceLabel.text = "within \(Int(sender.value)) miles."
    }
    @IBAction func nextAction(_ sender: UIBarButtonItem) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let filterVC = storyBoard.instantiateViewController(withIdentifier: Constants().kHomeSB) as! HomeViewController
        self.navigationController?.present(filterVC, animated: true, completion: nil)
    }
}

extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants().kfilterCell, for: indexPath) as! FilterCollectionViewCell
        
        let dataSource: CategoryEntities = self.cellCount![indexPath.row]
        cell.categoryName.text = dataSource.categoryName
        let url = NSURL(string: dataSource.categoryImagePath!)
        cell.categoryImage.sd_setImage(with: url as URL!)
        
        if cell.isSelected {
            cell.tickImageView.isHidden = false
        } else {
            cell.tickImageView.isHidden = true
        }
        
        
        return cell
    }
    
//    // Cell size and spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        return CGSize(width: (viewWidth/2)-5, height: viewHeight/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    // Selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell: FilterCollectionViewCell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        cell.tickImageView.isHidden = false
        
        
        selectedCategory = selectedCategory.filter(){$0 != indexPath[1]}
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: FilterCollectionViewCell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        cell.tickImageView.isHidden = true

        selectedCategory = selectedCategory.filter(){$0 != indexPath[1]}
    }
    
    
}
