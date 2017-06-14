//
//  ForgetPasswordViewController.swift
//  SmartCiti
//
//  Created by Sathish on 11/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ForgetPasswordViewController: UIViewController {

    @IBOutlet var startOutlet: UIButton!
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var resetPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        emailAddressTextField.layer.cornerRadius = 20
        resetPassword.layer.cornerRadius = 20
        
//        emailAddressTextField.text = "dineshnagarajan19@gmail.com"
    }

    @IBAction func startAction(_ sender: UIButton) {
    }
    @IBAction func restPasswordAction(_ sender: UIButton) {
        if(emailAddressTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter email address")
        } else {
            if(AppUtils.sharedInstance.isValidEmail(testStr: emailAddressTextField.text!)) {
                let headers: HTTPHeaders = ["": ""]
                let params: Parameters = ["email": emailAddressTextField.text!]
                
                let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
                ServiceManager.sharedInstance.executePostUrlEncodingObjectURL(type: Register.self, url: Constants().kBaseURL + Constants().kForgotPasswordURL, params: params, headers: headers, view: self.view, completion: {
                    response in
                    
                    if(response?.result.isSuccess)! {
                        let forgetInstance = response?.result.value
                        let statusCode = forgetInstance?.status?.status
                        let statusMessage = forgetInstance?.status?.message
                        
                        if (statusCode == 200) {
                            hub.hide(animated: true)
                            
                            let alert = UIAlertController(title: "Alert", message: "Check email for new password and login", preferredStyle: UIAlertControllerStyle.alert)
                            let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let loginVC = storyBoard.instantiateViewController(withIdentifier: Constants().kLoginSB) as! LoginView
                                self.navigationController?.pushViewController(loginVC, animated: true)
                            })
                           alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        } else if (statusCode == 206){
                            AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: statusMessage!)
                            hub.hide(animated: true)
                        }
                    } else if(response?.result.isFailure)! {
                        hub.hide(animated: true)
                        AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter registered email address")
                    }
                })
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "Alert", message: "Enter valid email address")
            }
            
        }
    }
}
