//
//  HourseOfOperationViewController.swift
//  SmartCiti
//
//  Created by Sathish on 22/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire

class HourseOfOperationViewController: UIViewController {

    @IBOutlet var daysCollectionView: UICollectionView!
    @IBOutlet var startTimeTextField: UITextField!
    @IBOutlet var endTimeTextField: UITextField!
    
    let days = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"]
    var selectedItems = [Int]()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    public var createEvent = [String]()
    var collectionViewSelectedCellArray = [String]()
    
//    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.createEvent)
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-arrow"), style: .plain, target: self, action: #selector(leftBarButtonAction))
        
        leftBarButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "HOURS OF OPERATION"
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.daysCollectionView.showsHorizontalScrollIndicator = false
        self.daysCollectionView.allowsMultipleSelection = true
        self.daysCollectionView.allowsSelection = true
        
//        let hours = Calendar.current.component(.hour, from: date)
//        let min = Calendar.current.component(.minute, from: date)
//        
//        startTimeTextField.placeholder = "\(hours):\(min)"
//        endTimeTextField.placeholder = "\(hours):\(min)"
        
        let createBusinessHeader: HTTPHeaders = ["Authorization": "bearer \(UserDefaults.standard.value(forKey: "accessToken")!)", "Content-Type": "application/json"]
        let createBusinessParams: Parameters = ["business_name": createEvent[0], "website_URL": createEvent[1], "phone_number": createEvent[2], "description": createEvent[4], "business_location": createEvent[5], "category_id": ["category_id": "1"], "parking_location": createEvent[6], "hoursOfOperation": [["week_days": "sunday", "start_time": "10:00:00", "end_time": "11:00:00"], ["week_days": "sunday", "start_time": "10:00:00", "end_time": "11:00:00"]]]
        
        // Need to fetch and identify category id from category name.
        print(createBusinessParams)
        ServiceManager.sharedInstance.executePostObjectURL(type: AddBusiness.self, url: "http://35.167.31.23:8080/smartcity/addbusiness", params: createBusinessParams, headers: createBusinessHeader, view: self.view, completion: {
            response in
            
            if(response?.result.isSuccess)! {
                if(response?.result.value?.status?.status == 200) {
                    print(response?.result.value?.entity?.businessId)
                    print(response?.result.value?.entity?.businessName)
                } else{
                    print(response?.result.value?.status?.status)
                }
                print("Add business success")
                
            } else if(response?.result.isFailure)! {
                print("Add business failure")
            }
        })
        
    }
    
    func leftBarButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func startTimeAction(_ sender: UITextField) {
        
        startTimePicker.datePickerMode = .dateAndTime
        startTimeTextField.inputView = startTimePicker
        startTimePicker.addTarget(self, action: #selector(startTimePickerAction), for: .valueChanged)
    }
    func startTimePickerAction(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
        if(sender == startTimePicker) {
            formatter.timeStyle = .short
            startTimeTextField.text = formatter.string(from: startTimePicker.date)
        } else if(sender == endTimePicker) {
            formatter.timeStyle = .short
            endTimeTextField.text = formatter.string(from: endTimePicker.date)
        }
        
    }
    @IBAction func endTimeAction(_ sender: UITextField) {
        
        endTimePicker.datePickerMode = .dateAndTime
        endTimeTextField.inputView = endTimePicker
        endTimePicker.addTarget(self, action: #selector(startTimePickerAction(sender:)), for: .valueChanged)
    }
    
    @IBAction func createBusinessAction(_ sender: UIButton) {
        
        let socialShareAlert = self.storyboard?.instantiateViewController(withIdentifier: "hourseOfOperationShareView")
        socialShareAlert?.modalPresentationStyle = .overCurrentContext
        socialShareAlert?.modalTransitionStyle = .crossDissolve
        
        self.present(socialShareAlert!, animated: true, completion: nil)
    }
    
}

extension HourseOfOperationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCollectionViewCell", for: indexPath) as! HourseOfOperationCollectionViewCell
        //let flowLayer = UICollectionViewFlowLayout()
        if cell.isSelected {
            cell.dayLabel.text = days[indexPath.row]
            cell.dayLabel.textColor = UIColor.white
            cell.backgroundColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 0.7)
            cell.layer.cornerRadius = 5.0
        } else {
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 0.5).cgColor
            cell.dayLabel.text = days[indexPath.row]
            cell.dayLabel.textColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 0.7)
            cell.backgroundColor = UIColor.clear
            cell.layer.cornerRadius = 5.0
        }

        return cell
    }
    
    // Collection view cell size and spacing
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        
        return CGSize(width: (viewWidth/2.5)-5, height: viewHeight/10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    // Collectionview select and deselect functions 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell: HourseOfOperationCollectionViewCell = collectionView.cellForItem(at: indexPath) as! HourseOfOperationCollectionViewCell
        let selectedDays = days[indexPath.row]
        
        collectionViewSelectedCellArray.append(selectedDays)
        print(collectionViewSelectedCellArray)
        cell.dayLabel.textColor = UIColor.white
        cell.backgroundColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 1)
    }

    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell: HourseOfOperationCollectionViewCell = collectionView.cellForItem(at: indexPath) as! HourseOfOperationCollectionViewCell
        
        let deselectedString = days[indexPath.row]
        collectionViewSelectedCellArray = collectionViewSelectedCellArray.filter{$0 != deselectedString}
        print(collectionViewSelectedCellArray)
        
//        if collectionViewSelectedCellArray.contains(deselectedString) {
//            collectionViewSelectedCellArray.remove(at: deselectedString)
//        } else {
//            
//        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 0.5).cgColor
        cell.dayLabel.textColor = UIColor.init(red: 44/255, green: 153/255, blue: 219/255, alpha: 0.7)
        cell.backgroundColor = UIColor.clear
    }
    
}
