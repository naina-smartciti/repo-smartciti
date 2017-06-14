//
//  CreateEventFormViewController.swift
//  SmartCiti
//
//  Created by Sathish on 22/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class CreateEventFormViewController: UIViewController {

    @IBOutlet var imageButton: UIButton!
    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var startTimeTextField: UITextField!
    @IBOutlet var endTimeTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var addYourEventLocationTextField: UITextField!
    @IBOutlet var membersAddedLabel: UILabel!
    @IBOutlet var inviteFamilyFriendsButton: UIButton!
    @IBOutlet var createEventButton: UIButton!
    @IBOutlet var createEventScrollView: UIScrollView!
    @IBOutlet var createEventImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-arrow"), style: .plain, target: self, action: #selector(backBarButtonAction))

        leftButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.title = "CREATE EVENT"
        
        self.createEventScrollView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func backBarButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func inviteFamilyFriendsButtonAction(_ sender: UIButton) {
    }
    @IBAction func createEventButtonAction(_ sender: UIButton) {
    }
    @IBAction func eventLocaitonButtonAction(_ sender: UIButton) {
    }
    @IBAction func imageButtonAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion:  nil)
    }
    
    
}

extension CreateEventFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chooseImage = info[UIImagePickerControllerEditedImage] as! UIImage
        createEventImageView.image = chooseImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
