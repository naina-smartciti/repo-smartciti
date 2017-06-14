//
//  LoginView.swift
//  SmartCiti
//
//  Created by Sathish on 07/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class LoginView: UIViewController {

    @IBOutlet var startOutlet: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var forgotPasswordOutlet: UIButton!
    @IBOutlet var createAccountOutlet: UIButton!

    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.hide(animated: true)
        // Create curve appearance
        userNameTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        loginOutlet.layer.cornerRadius = 20
        
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        userNameTextField.text = "dineshnagarajan19@gmail.com" // god@a.com - personal user
        passwordTextField.text = "123456"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Make it true to hide navidation bar
        navigationController?.navigationBar.isHidden = true
    }
    
    func validation() -> Bool {
        var isValid = true
        let passwordString: String = passwordTextField.text!
        
        if(userNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter user name.")
            isValid = false
            return isValid
        } else if (passwordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter password.")
            isValid = false
            return isValid
        } else if (passwordString.characters.count < 5) {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Password must be atleast of 5 characters")
            isValid = false
        }
        return isValid
    }
    

    @IBAction func startAction(_ sender: UIButton) {
        print("Start Action")
    }

    @IBAction func loginAction(_ sender: UIButton) {
        
        if (validation()) {
            // service call
            
            let parameters: Parameters = [
                "username": userNameTextField.text!,
                "password": passwordTextField.text!,
                "grant_type": "password"
            ]
            
            let headers: HTTPHeaders = [
                "Authorization": Constants().kBaseToken
            ]
            
            let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
            ServiceManager.sharedInstance.executePostUrlEncodingObjectURL(type: Device.self, url: Constants().kBaseURL+Constants().kLoginURL, params: parameters, headers: headers, view: self.view, completion: {
                response in
                if (response?.result.isSuccess)! {
                    let loginStatusCode = (response?.response?.statusCode)!
                    if(loginStatusCode == 200){

                        // MARK: User Defaults
                        UserDefaults.standard.set(response?.result.value?.accessToken, forKey: "accessToken")
                        UserDefaults.standard.set(response?.result.value?.user?.userType?.userTypeId, forKey: "userTypeId")
                        UserDefaults.standard.set(response?.result.value?.user?.userType?.userTypeName, forKey: "userTypeName")
                        
                        
                        let viewProfileParam: Parameters = ["": ""]
                        let viewProfileHeader: HTTPHeaders = ["Authorization": "bearer \(UserDefaults.standard.value(forKey: "accessToken")!)"]
                        print(viewProfileHeader)
                        print(viewProfileParam)
                        
                        loader.hide(animated: true)
                        
                        ServiceManager.sharedInstance.executeGetObjectURLEncoding(type: Register.self, url: Constants().kBaseURL+Constants().kViewProfileURL, params: viewProfileParam, headers: viewProfileHeader, view: self.view, completion: {
                            response in
                            
                            let viewProfile = response?.result.value
                            if (viewProfile?.status?.status == 200) {
                                if(viewProfile?.entity?.passwordForceUpdate)! {
                                    loader.hide(animated: true)
                                    let changePasswordVC = self.storyBoard.instantiateViewController(withIdentifier: Constants().kChangePassword)
                                    self.navigationController?.pushViewController(changePasswordVC, animated: true)
                                } else {
                                    loader.hide(animated: true)
                                    let filterVC = self.storyBoard.instantiateViewController(withIdentifier: Constants().kFilterSB) as! FilterViewController
                                    self.navigationController?.pushViewController(filterVC, animated: true)
                                }
                            } else {
                                loader.hide(animated: true)
                            }
                        })
                    } else {
                        print("Login status code error")
                    }
                } else if (response?.result.isFailure)! {
                    AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Bad credentials")
                    loader.hide(animated: true)
                }
            })
            print("valid")
        } else {
            print("not valid")
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        print("Forgot Password Action")
        
        let forgotPasswordVC = storyBoard.instantiateViewController(withIdentifier: Constants().kForgetPassword) as! ForgetPasswordViewController
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        print("Create Account Action")
        let createAccountVC = storyBoard.instantiateViewController(withIdentifier: Constants().kRegisterSB)
        self.navigationController?.pushViewController(createAccountVC, animated: true)
    }
}
