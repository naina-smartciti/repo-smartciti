//
//  BusinessRegisterViewController.swift
//  SmartCiti
//
//  Created by Sathish on 08/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class BusinessRegisterViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var businessNameTextField: UITextField!
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var businsessNameLabel: UILabel!
    @IBOutlet var emailAddressLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func validation() -> Bool {
        var isValid = true
        
        if(firstNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter first name.")
            isValid = false
            return isValid
        } else if (lastNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter last name.")
            isValid = false
            return isValid
        } else if(businessNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter business name")
            isValid = false
            return isValid
        } else {
            isValid = true
        }
        if(emailAddressTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter email address.")
            isValid = false
            return isValid
        } else {
            if(AppUtils.sharedInstance.isValidEmail(testStr: emailAddressTextField.text!)){
                isValid = true
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter valid email address.")
                isValid = false
                return isValid
            }
        }
        if (passwordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter password")
            isValid = false
            return isValid
        } else {
            let passwordString: String = passwordTextField.text!
            if(passwordString.characters.count < 6) {
                AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Enter password of atleast 6 characters.")
                isValid = false
                return isValid
            } else if (passwordString.characters.count >= 6) {
                isValid = true
            }
        }
        
        
        
        return isValid
    }

    @IBAction func signUpAction(_ sender: UIButton) {

        if (validation()) {
            print("Valid")
            
            let subParameter: Dictionary = ["userTypeId": "2"]
            let parameters: Parameters = [
                "firstName": firstNameTextField.text!,
                "lastName": lastNameTextField.text!,
                "email": emailAddressTextField.text!,
                "password": passwordTextField.text!,
                "facebook_id": "",
                "businessName" : businessNameTextField.text!,
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
                    let businessInstance = response?.result.value
                    let statusCode = businessInstance?.status?.status
                    
                    if(statusCode == 200) {
                        loader.hide(animated: true)
                        
                        let loginParameters: Parameters = [
                            "username": self.emailAddressTextField.text!,
                            "password": self.passwordTextField.text!,
                            "grant_type": "password"
                        ]
                        
                        let loginHeaders: HTTPHeaders = [
                            "Authorization": Constants().kBaseToken
                        ]
                        print(loginParameters)
                        print(loginHeaders)
                        ServiceManager.sharedInstance.executePostUrlEncodingObjectURL(type: Device.self, url: Constants().kBaseURL+Constants().kLoginURL, params: loginParameters, headers: loginHeaders, view: self.view, completion: {
                            response in
                            if (response?.result.isSuccess)! {
                                let loginStatusCode = (response?.response?.statusCode)!
                                if(loginStatusCode == 200){
                                    loader.hide(animated: true)
                                    UserDefaults.standard.setValue(response?.result.value?.accessToken, forKey: "accessToken")
                                    
                                    let alert = UIAlertController(title: "Alert", message: "Registered Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                                        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: Constants().kFilterSB) as! FilterViewController
                                        self.navigationController?.pushViewController(filterVC, animated: true)
                                    })
                                    alert.addAction(alertAction)
                                    self.present(alert, animated: true, completion: nil)
                                    
                                } else {
                                    loader.hide(animated: true)
                                    print("Login status code error")
                                }
                            } else if (response?.result.isFailure)! {
                                AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Bad credentials")
                                loader.hide(animated: true)
                            }
                        })
                    } else if (businessInstance?.status?.status == 302) {
                        loader.hide(animated: true)
                        AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: (businessInstance?.status?.message)!)
                    } else if (businessInstance?.status?.status == 208) {
                        loader.hide(animated: true)
                        AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: (businessInstance?.status?.message)!)
                    } else if (response?.result.isFailure)! {
                        loader.hide(animated: true)
                        print("Business register view controller")
                        print((response?.response?.statusCode)!)
                    }
                } else if (response?.result.isFailure)! {
                    AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Registration Failure")
                }
            })
            
        } else {
            print("Invalid")
        }
    }
}
