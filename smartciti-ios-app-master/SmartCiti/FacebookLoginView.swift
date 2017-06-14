//
//  ViewController.swift
//  SmartCiti
//
//  Created by Sathish on 06/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Foundation
import Alamofire
import MBProgressHUD

class FacebookLoginView: UIViewController {

    @IBOutlet var startOutlet: UIButton!
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var facebookOutlet: UIButton!
    @IBOutlet var createAccountOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginOutlet.layer.cornerRadius = 20

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: Button action methods
    
    @IBAction func startAction(_ sender: UIButton) {
        print("Start Action")
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        print("Login Action")
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn([.publicProfile, .email, .userFriends], viewController: self) {
            loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User Cancelled login")
            case .success( _, _, let accessToken):
                print("Facebook Login Success")
                let req =  GraphRequest(graphPath: "me", parameters: ["fields":"email,first_name,last_name,gender,picture"], accessToken: accessToken, httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!)
                req.start({ (connection, result) in
                    switch result {
                    case .failed(let error):
                        print(error)
                        
                    case .success(let graphResponse):
                        if let responseDictionary = graphResponse.dictionaryValue {
                            print(responseDictionary)
                            let firstNameFB = responseDictionary["first_name"] as! String
                            let lastNameFB = responseDictionary["last_name"] as! String
                            let emailFB = responseDictionary["email"] as! String
                            let socialIdFB = responseDictionary["id"] as! String
                            let genderFB = responseDictionary["gender"] as! String
                            let pictureUrlFB = responseDictionary["picture"] as! [String:Any]
                            let photoData = pictureUrlFB["data"] as! [String:Any]
                            let photoUrl = photoData["url"] as! String
                            print(firstNameFB, lastNameFB, socialIdFB, genderFB, photoUrl)
                            
                            // Register service cal;
                            let date = NSDate()
                            let dateForm = DateFormatter()
                            dateForm.dateFormat = "MM-dd-yyyy"
                            let currentDate = dateForm.string(from: date as Date)
                            
                            let parameters: Parameters = [
                                "firstName": firstNameFB,
                                "lastName": lastNameFB,
                                "email": emailFB,
                                "password": "",
                                "facebook_id": socialIdFB,
                                "dob" : currentDate,
                                "userType": ["userTypeId": 1]
                            ]
                            let headers: HTTPHeaders = [
                                "Content-Type": "application/json"
                            ]
                            print("\(parameters) \(headers)")
                            
                            ServiceManager.sharedInstance.executePostObjectURL(type: Register.self, url: Constants().kBaseURL+Constants().kRegisterURL, params: parameters, headers: headers, view: self.view, completion: {
                                response in
                                let statusCode = (response?.result.value?.status?.status)!
                                let statusMessage = (response?.result.value?.status?.message)!
                                if (response?.result.isSuccess)! {
                                    
                                    if (statusCode == 200 || statusCode == 208) {
                                        print(statusCode)
                                        print(statusMessage)
                                        
                                        // Facebook login service call
                                        let parameters: Parameters = ["email": emailFB, "facebook_id": socialIdFB]
                                        let headers: HTTPHeaders = [:]
                                        
                                        ServiceManager.sharedInstance.executePostUrlEncodingObjectURL(type: Register.self, url: Constants().kBaseURL+Constants().kFacebookLoginURL, params: parameters, headers: headers, view: self.view, completion: {
                                            response in
                                            let fbStatusCode = (response?.result.value?.status?.status)!
                                            let fbStatusMessage = (response?.result.value?.status?.message)!
                                            if (response?.result.isSuccess)!  {
                                                if(fbStatusCode == 200) {
                                                    
                                                    // Login service call
                                                    let loginParameters: Parameters = ["username": emailFB, "password": socialIdFB, "grant_type": "password"]
                                                    let loginHeader: HTTPHeaders = ["Authorization": "\(Constants().kBaseToken)"]
                                                    
                                                    let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                    ServiceManager.sharedInstance.executePostUrlEncodingObjectURL(type: Device.self, url: Constants().kBaseURL+Constants().kLoginURL, params: loginParameters, headers: loginHeader, view: self.view, completion: {
                                                        response in
                                                        if (response?.result.isSuccess)! {
                                                            let loginStatusCode = (response?.response?.statusCode)!
                                                            if(loginStatusCode == 200){
                                                                
                                                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                let filterVC = storyBoard.instantiateViewController(withIdentifier: Constants().kFilterSB) as! FilterViewController
                                                                self.navigationController?.pushViewController(filterVC, animated: true)
                                                                //UIApplication.shared.keyWindow?.rootViewController = filterVC
                                                                
                                                                loader.hide(animated: true)
                                                            } else {
                                                                print("Login status code error")
                                                            }
                                                        } else if (response?.result.isFailure)! {
                                                            AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Bad credentials")
                                                            loader.hide(animated: true)
                                                        }
                                                    })
                                                } else {
                                                    print("Facebook status code: \(fbStatusCode)")
                                                    print("Facebook status message: \(fbStatusMessage)")
                                                }
                                            }
                                        })
                                    }  else {
                                        AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: "Facebook Login error")
                                        print("Check status code \(response?.result.value?.status?.status)")
                                        print("Status message \(response?.result.value?.status?.message)")
                                    }
                                    
                                } else if (response?.result.isFailure)! {
                                    AppUtils.sharedInstance.simpleAlert(view: self, title: Constants().kAlertTitle, message: Constants().kRegistationFail)
                                }
                            })

                        }
                    }
                })
            }
        }
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        print("Create Account Action")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyBoard.instantiateViewController(withIdentifier: Constants().kRegisterSB)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
