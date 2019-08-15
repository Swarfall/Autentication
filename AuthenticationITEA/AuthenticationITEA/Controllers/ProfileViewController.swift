//
//  ProfileViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 7/25/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dayOfBirthdayLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    var studentModel = AuthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
        putDataLabels(label: emailLabel, data: studentModel.email ?? "no info", info: "email:")
        putDataLabels(label: nameLabel, data: studentModel.name ?? "no info", info: "name:")
        putDataLabels(label: surnameLabel, data: studentModel.surname ?? "no info", info: "surname:")
        putDataLabels(label: ageLabel, data: studentModel.age ?? "no info", info: "age:")
        putDataLabels(label: cityLabel, data: studentModel.city ?? "no info", info: "city:")
        putDataLabels(label: dayOfBirthdayLabel, data: studentModel.dayOfBirthday ?? "no info", info: "day of birth:")
        putDataLabels(label: phoneLabel, data: studentModel.phone ?? "no info", info: "phone:")
        putDataLabels(label: stateLabel, data: studentModel.state ?? "no info", info: "state:")
        putDataLabels(label: zipLabel, data: studentModel.zip ?? "no info", info: "zip:")
        putDataLabels(label: countryLabel, data: studentModel.country ?? "no info", info: "country:")
        passwordTextField.text = studentModel.password ?? "no info"
        locationLabel.text = "location: lat: \(String(describing: studentModel.lat ?? 0)), long: \(String(describing: studentModel.long ?? 0))"
        logOutButton.layer.borderWidth = 1.0
        logOutButton.layer.borderColor = UIColor.white.cgColor
        logOutButton.layer.cornerRadius = 10;
        logOutButton.clipsToBounds = true
    }
    
    @IBAction func didTapLogOutButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapShowPassword(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == true{
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    func putDataLabels(label: UILabel, data: String, info: String) {
        label.text = "\(info) \(data)"
    }
    
    @IBAction func didTapGoToPopVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOpenEmailButton(_ sender: Any) {
        sendMail(setToRecipients: [studentModel.email ?? ""], subject: studentModel.name ?? "")
    }
    
    @IBAction func didTapOpenSMSButton(_ sender: Any) {
        sendMessage(recipients: [studentModel.phone ?? ""], subject: studentModel.name ?? "")
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,   error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{
    
    //MARK: Email
    func sendMail(setToRecipients: [String], subject: String) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(setToRecipients)
        composeVC.setSubject("Hello, \(subject)")
        composeVC.setMessageBody("SOMETHING MUST BE HERE", isHTML: false)
        present(composeVC, animated: true, completion: nil)
    }
    
    //MARK: SMS
    func sendMessage(recipients: [String], subject: String) {
        let messageCompose = MFMessageComposeViewController()
        messageCompose.messageComposeDelegate = self
        messageCompose.recipients = recipients
        messageCompose.body = "Hello, \(subject)"
        messageCompose.subject = "Hello, \(subject)"
        present(messageCompose, animated: true, completion: nil)
    }
}
