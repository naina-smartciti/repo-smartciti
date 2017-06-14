//
//  PersonalRegisterViewController.swift
//  SmartCiti
//
//  Created by Sathish on 08/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class PersonalRegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var birthdayTextField: UITextField!
    @IBOutlet var signupButtonOutlet: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var emailAddressLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayTextField.delegate = self

    }
    
    // Birthday date picker
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        birthdayTextField.text = formatter.string(from: sender.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date

        datePicker.maximumDate = NSDate() as Date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    
    func validation() -> Bool {
        var isValid = true
        
        if (firstNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter first name.")
            isValid = false
            return isValid
        } else if (lastNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter last name.")
            isValid = false
            return isValid
        } else if (emailAddressTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter email address.")
            isValid = false
            return isValid
        } else if (AppUtils.sharedInstance.isValidEmail(testStr: emailAddressTextField.text!)) {
            isValid = true
        } else {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter valid email address.")
            isValid = false
            return isValid
        }
        if(passwordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter password")
            isValid = false
            return isValid
        }else {
            let passwordString: String = passwordTextField.text!
            if(passwordString.characters.count < 6) {
                AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter password of atleast 6 characters.")
                isValid = false
                return isValid
            } else if (passwordString.characters.count >= 6) {
                isValid = true
            }
        }
        if (birthdayTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Select date of birth")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        return isValid
    }
    
    @IBAction func signUPAction(_ sender: UIButton) {
        
        if (validation()) {
            print("valid")
            let subParameter: Dictionary = ["userTypeId": "1"]
            let parameters: Parameters = [
                "firstName": firstNameTextField.text!,
                "lastName": lastNameTextField.text!,
                "email": emailAddressTextField.text!,
                "password": passwordTextField.text!,
                "facebook_id": "",
                "dob" : birthdayTextField.text!,
                "userType": subParameter
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
                ]
            print("Personal reg parameters: \(parameters)")
            print("Personal reg header: \(headers)")
            let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
            ServiceManager.sharedInstance.executePostObjectURL(type: Register.self, url: Constants().kBaseURL+Constants().kRegisterURL, params: parameters, headers: headers, view: self.view, completion: {
                response in
                if (response?.result.isSuccess)! {
                    loader.hide(animated: true)
                    
                    if(response?.result.value?.status?.status == 200) {
                        
                        let parameters: Parameters = [
                            "username": self.emailAddressTextField.text!,
                            "password": self.passwordTextField.text!,
                            "grant_type": "password"
                        ]
                        
                        let headers: HTTPHeaders = [
                            "Authorization": Constants().kBaseToken
                        ]
                        
                        ServiceManager.sharedInstance.executePostUrlEncodingObjectURL(type: Device.self, url: Constants().kBaseURL+Constants().kLoginURL, params: parameters, headers: headers, view: self.view, completion: {
                            response in
                            if (response?.result.isSuccess)! {
                                
                                let loginStatusCode = (response?.response?.statusCode)!
                                
                                if(loginStatusCode == 200){
                                    loader.hide(animated: true)
                                    
                                    UserDefaults.standard.setValue(response?.result.value?.accessToken, forKey: "accessToken")
                                    print(UserDefaults.standard.value(forKey: "accessToken")!)
                                    
                                    let alert = UIAlertController(title: "Alert", message: "Registered Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                                        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: Constants().kFilterSB) as! FilterViewController
                                        self.navigationController?.pushViewController(filterVC, animated: true)
                                    })
                                    alert.addAction(alertAction)
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    
                                    
                                } else {
                                    print("Login status code error")
                                }
                            } else if (response?.result.isFailure)! {
                                AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Bad credentials")
                                loader.hide(animated: true)
                            }
                        })
                    } else if(response?.result.value?.status?.status == 208) {
                        let alert = UIAlertController(title: "Alert", message: "User Already Exists", preferredStyle: UIAlertControllerStyle.alert)
                        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        print("registration problem")
                    }
                    
                } else if (response?.result.isFailure)! {
                    AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Registration Failure")
                    loader.hide(animated: true)
                }
            })
            
        } else {
            print("invalid")
        }
        
    }

}
