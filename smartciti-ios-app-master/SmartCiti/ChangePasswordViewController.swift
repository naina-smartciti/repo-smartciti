//
//  ChangePasswordViewController.swift
//  SmartCiti
//
//  Created by Sathish on 11/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ChangePasswordViewController: UIViewController {

    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var changePasswordOutlet: UIButton!
    
    let forgetPassword = ForgetPasswordViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changePasswordOutlet.layer.cornerRadius = 20
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "nav-arrow"), style: .done, target: self, action: #selector(backButtonAction))
        leftBarButton.tintColor = UIColor.black
        
        // disable swipe back
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.title = "Change Password"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func backButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePasswordAction(_ sender: UIButton) {
        
        // Verification with service call
        if(codeTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter verification code")
        } else if (newPasswordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter password")
        } else if (confirmPasswordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter confirm password")
        } else {
            if (newPasswordTextField.text == confirmPasswordTextField.text) {
                
                        let changeParams: Parameters = ["password": self.codeTextField.text!, "newPassword": self.newPasswordTextField.text!, "confirmPassword": self.confirmPasswordTextField.text!]
                        let changeHeaders: HTTPHeaders = ["Authorization": "bearer \(UserDefaults.standard.value(forKey: "accessToken")!)", "Content-Type": "application/json"]
                        
                        // Service call to change password.
                        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
                        ServiceManager.sharedInstance.executePostObjectURL(type: Register.self, url: Constants().kBaseURL+Constants().kChangePasswordURL, params: changeParams, headers: changeHeaders, view: self.view, completion: {
                            response in
                            if(response?.result.isSuccess)! {
                                if(response?.result.value?.status?.status == 200) {
                                    
                                    let alert = UIAlertController(title: "Alert", message: "Password changed successfully", preferredStyle: UIAlertControllerStyle.alert)
                                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                                        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: Constants().kFilterSB) as! FilterViewController
                                        self.navigationController?.pushViewController(filterVC, animated: true)
                                    })
                                    alert.addAction(alertAction)
                                    self.present(alert, animated: true, completion: nil)
                                    loader.hide(animated: true)
                                } else {
                                    print("failure")
                                }
                                
                            } else if(response?.result.isFailure)! {
                                AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter valid verfication code.")
                                loader.hide(animated: true)
                            }
                        })
            }else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Password doesn't match.")
            }
            
        }
        
    }
}
