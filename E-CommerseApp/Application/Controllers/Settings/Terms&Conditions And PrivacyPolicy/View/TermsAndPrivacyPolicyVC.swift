//
//  TermsAndPrivacyPolicyVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/4/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit
import WebKit

class TermsAndPrivacyPolicyVC: CustomController,UIWebViewDelegate
{
    
    @IBOutlet var viewWeb: UIWebView!
    
    var approach = "terms"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = URL(string: "www.cerebruminfotech.com")
        if(self.approach == "terms")
        {
            self.title = "TERMS & CONDITIONS"
           // let url = URL(string: kTermsConditions)
            viewWeb.loadRequest(URLRequest(url: url!))
        }
        else if(self.approach == "aboutUs")
        {
            self.title = "ABOUT US"
           // let url = URL(string: kAboutUs)
            viewWeb.loadRequest(URLRequest(url: url!))
        }
        else
        {
            self.title = "PRIVACY POLICY"
           // let url = URL(string: kPrivacy)
            viewWeb.loadRequest(URLRequest(url: url!))
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func movBack(_ sender: Any)
    {
        self.moveBACK(controller: self)
    }
    
    
}
