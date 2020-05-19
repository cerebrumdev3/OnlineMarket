//
//  HomeVC.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 5/19/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class HomeVC: CustomController
{
    @IBOutlet weak var btnDrawer: UIBarButtonItem!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setView()

        // Do any additional setup after loading the view.
    }
    

    //MARK:- SETTING UI APPROACH
    func setView()
    {
        //NAvigationBAR
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
