//
//  LoginViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 7/27/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import SwiftGifOrigin

class LoginViewController: UIViewController {

    @IBOutlet weak var pandaGifImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var heighViewConstrain: NSLayoutConstraint!
    @IBOutlet weak var signInButton: UIButton!
    
    var studentModel = AuthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pandaGifImageView.loadGif(name: "pandaGif")
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.layer.cornerRadius = 10;
        signInButton.clipsToBounds = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        getDataFirebase()
    }
    
    func getDataFirebase() {
        let ref = Database.database().reference(withPath: "student")
        ref.queryOrderedByKey().observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as? [String: Any]
            
            if let email = snapshotValue?["email"] as? String {
                self.studentModel.email = email
            }
            if let password = snapshotValue?["password"] as? String {
                self.studentModel.password = password
            }
            if let name = snapshotValue?["name"] as? String {
                self.studentModel.name = name
            }
            if let surname = snapshotValue?["surname"] as? String {
                self.studentModel.surname = surname
            }
            if let age = snapshotValue?["age"] as? String {
                self.studentModel.age = age
            }
            if let city = snapshotValue?["city"] as? String {
                self.studentModel.city = city
            }
            if let dayOfBirthday = snapshotValue?["birthday"] as? String {
                self.studentModel.dayOfBirthday = dayOfBirthday
            }
            if let phone = snapshotValue?["phone"] as? String {
                self.studentModel.phone = phone
            }
            if let state = snapshotValue?["state"] as? String {
                self.studentModel.state = state
            }
            if let zip = snapshotValue?["zip"] as? String {
                self.studentModel.zip = zip
            }
            if let country = snapshotValue?["country"] as? String {
                self.studentModel.country = country
            }
            if let lat  = snapshotValue?["lat"] as? Double {
                self.studentModel.lat = lat
            }
            if let long = snapshotValue?["long"] as? Double {
                self.studentModel.long = long
            }
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        if emailTextField.text == studentModel.email && passwordTextField.text == studentModel.password {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            vc.authModel = studentModel
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            heighViewConstrain.priority = UILayoutPriority(rawValue: 900)
        }
    }
    
    @IBAction func didTapShowPassword(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == true{
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordTextField.isSecureTextEntry = true
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            heighViewConstrain.priority = UILayoutPriority(rawValue: 700)
        case passwordTextField:
            heighViewConstrain.priority = UILayoutPriority(rawValue: 700)
        default:
            break
        }
    }
}
