//
//  WebViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 8/14/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var siteWebView: WKWebView!
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        siteWebView.navigationDelegate = self
        let myURL = URL(string: url)
        guard let URL = myURL else {
            return
        }
        let myRequest = URLRequest(url: URL)
        siteWebView.load(myRequest)
    }
    
    @IBAction func didTapGoToPopVC(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
}
