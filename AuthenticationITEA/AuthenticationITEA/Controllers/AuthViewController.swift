//
//  ViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 7/24/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import SwiftGifOrigin

class AuthViewController: UIViewController {

    @IBOutlet weak var pandaImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var surnameView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var zipView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    
    var studentModel = AuthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         pandaImageView.loadGif(name: "pandaGif")
         signInButton.layer.borderWidth = 1.0
         signInButton.layer.borderColor = UIColor.white.cgColor
         signInButton.layer.cornerRadius = 10;
         signInButton.clipsToBounds = true
         subscribeToTheTextFieldDelegate(textField: emailTextField)
         subscribeToTheTextFieldDelegate(textField: passwordTextField)
         subscribeToTheTextFieldDelegate(textField: nameTextField)
         subscribeToTheTextFieldDelegate(textField: surnameTextField)
         subscribeToTheTextFieldDelegate(textField: cityTextField)
         subscribeToTheTextFieldDelegate(textField: longTextField)
         subscribeToTheTextFieldDelegate(textField: latTextField)
         subscribeToTheTextFieldDelegate(textField: stateTextField)
         subscribeToTheTextFieldDelegate(textField: countryTextField)
        post()
    }

    @IBAction func didTapSignInButton(_ sender: Any) {
        if emailTextField.text != studentModel.email {
            emailLabel.textColor = .red
            emailView.backgroundColor = .red
        }
        if passwordTextField.text != studentModel.password {
            passwordLabel.textColor = .red
            passwordView.backgroundColor = .red
        }
        if nameTextField.text != studentModel.name {
            nameLabel.textColor = .red
            nameView.backgroundColor = .red
        }
        if surnameTextField.text != studentModel.surname {
            surnameLabel.textColor = .red
            surnameView.backgroundColor = .red
        }
        if ageTextField.text != studentModel.age {
            ageLabel.textColor = .red
            ageView.backgroundColor = .red
        }
        if cityTextField.text != studentModel.city {
            cityLabel.textColor = .red
            cityView.backgroundColor = .red
        }
        if birthdayTextField.text != studentModel.dayOfBirthday {
            birthdayLabel.textColor = .red
            birthdayView.backgroundColor = .red
        }
        if phoneTextField.text != studentModel.phone {
            phoneLabel.textColor = .red
            phoneView.backgroundColor = .red
        }
        if stateTextField.text != studentModel.state {
            stateLabel.textColor = .red
            stateView.backgroundColor = .red
        }
        if zipTextField.text != studentModel.zip {
            zipLabel.textColor = .red
            zipView.backgroundColor = .red
        }
        if countryTextField.text != studentModel.country {
            countryLabel.textColor = .red
            countryView.backgroundColor = .red
        }
        if latTextField.text != String(studentModel.lat ?? 0) || longTextField.text != String(studentModel.long ?? 0) {
            locationLabel.textColor = .red
            locationView.backgroundColor = .red
        }
    }
    
    func post() {
        let ref = Database.database().reference(withPath: "student")
        ref.queryOrderedByKey().observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as? [String: Any]
            
            if let email = snapshotValue?["email"] as? String {
                self.studentModel.email = email
                debugPrint(email)
            }
            if let password = snapshotValue?["password"] as? String {
                self.studentModel.password = password
                debugPrint(password)
            }
            if let name = snapshotValue?["name"] as? String {
                self.studentModel.name = name
                debugPrint(name)
            }
            if let surname = snapshotValue?["surname"] as? String {
                self.studentModel.surname = surname
                debugPrint(surname)
            }
            if let age = snapshotValue?["age"] as? String {
                self.studentModel.age = age
                debugPrint(age)
            }
            if let city = snapshotValue?["city"] as? String {
                self.studentModel.city = city
                debugPrint(city)
            }
            if let dayOfBirthday = snapshotValue?["birthday"] as? String {
                self.studentModel.dayOfBirthday = dayOfBirthday
                debugPrint(dayOfBirthday)
            }
            if let phone = snapshotValue?["phone"] as? String {
                self.studentModel.phone = phone
                debugPrint(phone)
            }
            if let state = snapshotValue?["state"] as? String {
                self.studentModel.state = state
                debugPrint(state)
            }
            if let zip = snapshotValue?["zip"] as? String {
                self.studentModel.zip = zip
                debugPrint(zip)
            }
            if let country = snapshotValue?["country"] as? String {
                self.studentModel.country = country
                debugPrint(country)
            }
            if let lat  = snapshotValue?["lat"] as? Double {
                self.studentModel.lat = lat
                debugPrint(lat)
            }
            if let long = snapshotValue?["long"] as? Double {
                self.studentModel.long = long
                debugPrint(long)
            }
        }
        
    }
    
    func subscribeToTheTextFieldDelegate(textField: UITextField) {
        textField.delegate = self
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        birthdayTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        longTextField.resignFirstResponder()
        latTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
        case emailTextField:
            didBeginEditing(label: emailLabel, view: emailView)
        case passwordTextField:
            didBeginEditing(label: passwordLabel, view: passwordView)
        case nameTextField:
            didBeginEditing(label: nameLabel, view: nameView)
        case surnameTextField:
            didBeginEditing(label: surnameLabel, view: surnameView)
        case ageTextField:
            didBeginEditing(label: ageLabel, view: ageView)
        case cityTextField:
            didBeginEditing(label: cityLabel, view: cityView)
        case birthdayTextField:
            //didBeginEditing(label: birthdayLabel, view: birthdayView)
            birthdayLabel.textColor = .white
            birthdayView.backgroundColor = .white
        case longTextField:
            didBeginEditing(label: locationLabel, view: locationView)
        case latTextField:
            didBeginEditing(label: locationLabel, view: locationView)
        case phoneTextField:
            didBeginEditing(label: phoneLabel, view: phoneView)
        case stateTextField:
            didBeginEditing(label: stateLabel, view: stateView)
        case zipTextField:
            didBeginEditing(label: zipLabel, view: zipView)
        case countryTextField:
            didBeginEditing(label: countryLabel, view: countryView)
        default:
            break
        }
    }
    
    func didBeginEditing(label: UILabel, view: UIView) {
        label.textColor = .white
        view.backgroundColor = .white
    }
}
