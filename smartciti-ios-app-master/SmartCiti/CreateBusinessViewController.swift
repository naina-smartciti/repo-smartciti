//
//  CreateBusinessViewController.swift
//  SmartCiti
//
//  Created by Sathish on 21/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire

class CreateBusinessViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var businessImageView: UIImageView!
    @IBOutlet var createBusinessScrollView: UIScrollView!
    @IBOutlet var businessContentView: UIView!
    @IBOutlet var businessLocationView: UIView!
    @IBOutlet var parkingLocationView: UIView!
    @IBOutlet var businessNameTextField: UITextField!
    @IBOutlet var webURLTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var addBusinessLocationTextField: UITextField!
    @IBOutlet var addParkingLocationTextField: UITextField!

    var categoryList: Array = [String]()
    let categoryPicker = UIPickerView()
    var createAccountValues = [String]()
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        businessNameTextField.text = "business name"
//        webURLTextField.text = "weburl.com"
//        phoneNumberTextField.text = "988676654"
//        categoryTextField.text = "category list"
//        descriptionTextField.text = "description"
//        addBusinessLocationTextField.text = "business location"
//        addParkingLocationTextField.text = "parking location"
        
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-arrow"), style: .plain, target: self, action: #selector(leftBarButtonAction))
        
        leftBarButton.tintColor = UIColor.black
        self.navigationItem.title = "Create Business"
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.createBusinessScrollView.showsVerticalScrollIndicator = false
        
        categoryTextField.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        
        
        // Get category service call
        let categoryParams: Parameters = ["": ""]
        let categoryHeader: HTTPHeaders = ["Authorization": "bearer \(UserDefaults.standard.value(forKey: "accessToken")!)"]
        
        ServiceManager.sharedInstance.executeGetObjectURLEncoding(type: CategoryList.self, url: Constants().kBaseURL+Constants().kCategoryList, params: categoryParams, headers: categoryHeader, view: self.view, completion: {
            response in
            
            if(response?.result.value?.status?.status == 200) {
                
                for categoryEntity in (response?.result.value?.categoryEntities)! {
                
                    self.categoryList.append(categoryEntity.categoryName!)
                    
                }
            } else {
                print("failure")
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func leftBarButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func businessImageAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion:  nil)
    }
    
    @IBAction func categoryAction(_ sender: UITextField) {
        
        categoryTextField.inputView = categoryPicker
    }
    
    func isValid() -> Bool {
        var isValid = true
        
        
        if(businessNameTextField.text?.isEmpty)!{
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter business name.")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        
        if(webURLTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter business web URL.")
            isValid = false
            return isValid
        } else{
            isValid = true
        }
        
        if(phoneNumberTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter phone number")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        
        if(categoryTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter category")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        
        if(descriptionTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter description")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        
        if(addBusinessLocationTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Add business location")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        
        if(addParkingLocationTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Add parking location")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        
        
        return isValid
    }

    @IBAction func addBusinessLocationAction(_ sender: UIButton) {
        print("select business location")
    }
    @IBAction func addParkingLocationAction(_ sender: UIButton) {
        print("select parking locaiton")
    }
    @IBAction func createAccount(_ sender: UIButton) {


        
        if(isValid()){
            print("Create account")
            
            
            createAccountValues = [businessNameTextField.text!, webURLTextField.text!, phoneNumberTextField.text!, categoryTextField.text!, descriptionTextField.text!, addBusinessLocationTextField.text!, addParkingLocationTextField.text!]
            print(createAccountValues)
            let hourseVC = self.storyboard?.instantiateViewController(withIdentifier: "hourseOfOperationSB") as! HourseOfOperationViewController
            hourseVC.createEvent = createAccountValues
            self.navigationController?.pushViewController(hourseVC, animated: true)
        } else {
            print("In Valid")
        }
    }
}

extension CreateBusinessViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
}

extension CreateBusinessViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        categoryTextField.text = categoryList[row]
    }
}

// Image picker

extension CreateBusinessViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chooseImage = info[UIImagePickerControllerEditedImage] as! UIImage
        businessImageView.image = chooseImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
