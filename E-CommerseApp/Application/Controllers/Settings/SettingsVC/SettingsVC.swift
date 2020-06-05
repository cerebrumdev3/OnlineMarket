//
//  SettingsVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/21/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class SettingsVC: CustomController
{
    
    
    @IBOutlet var btnDrawer: UIBarButtonItem!
    @IBOutlet var tblViw: UITableView!
    
    var Menu:[String]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Menu = ["Terms and Conditions","Privacy Policy","FAQ","Feedback","Contact Us"]
        self.tblViw.reloadData()
        self.tblViw.layer.cornerRadius = 10
        self.tblViw.layer.borderColor = UIColor.black.cgColor
        self.tblViw.layer.borderWidth = 1
        
        btnDrawer.target = self.revealViewController()
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cellAction(_ sender: UIButton)
    {
        switch sender.tag
        {
        case 0:
            
            let controller = Navigation.GetInstance(of: .TermsAndPrivacyPolicyVC) as! TermsAndPrivacyPolicyVC
            controller.approach = "terms"
            self.push_To_Controller(from_controller: self, to_Controller: controller)
            
            break
        case 1:
            
            let controller = Navigation.GetInstance(of: .TermsAndPrivacyPolicyVC) as! TermsAndPrivacyPolicyVC
            controller.approach = "privacy"
            self.push_To_Controller(from_controller: self, to_Controller: controller)
            
            break
        case 2:
            
            let controller = Navigation.GetInstance(of: .FAQVC) as! FAQVC
            self.push_To_Controller(from_controller: self, to_Controller: controller)
            
            break
            
        case 3:
            
            self.showAlertMessage(titleStr: kAppName, messageStr: "Coming Soon!")
            
            break
            
        case 4:
            
            self.showAlertMessage(titleStr: kAppName, messageStr: "Coming Soon!")
            
            break
            
        default: break
            
        }
    }
    
    
}

//MARK:- UITableViewDelegate
extension SettingsVC : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.Menu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellClass_Settings", for: indexPath)as! CellClass_Settings
        cell.lblText.text = self.Menu![indexPath.row]
        cell.btnTapOnCell.tag = indexPath.row
        return cell
    }
    
}
