//
//  DetailNewsViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 7/31/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import Kingfisher

class DetailNewsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var goToSiteButton: UIButton!
    
    var newsModel = NewsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.delegate = self
        descriptionTextView.isEditable = false
        setDesignGoToSiteButton(button: goToSiteButton)
        dataTransferToUI()
    }
    
    func dataTransferToUI() {
        nameLabel.text = newsModel.name
        let imageURL = URL(string: newsModel.urlToImage ?? "")
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: imageURL)
        titleLabel.text = newsModel.title
        descriptionTextView.text = newsModel.descriptionText
    }
    
    func setDesignGoToSiteButton(button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    @IBAction func didTapGoToPopVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapGoToSite(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.url = newsModel.urlSite ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
