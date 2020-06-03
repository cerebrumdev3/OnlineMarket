//
//  WriteReviewVC.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/3/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import Cosmos
import KMPlaceholderTextView

class WriteReviewVC: UIViewController
{

    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var collcnView: UICollectionView!
    @IBOutlet var viewRatings: CosmosView!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var tfReview: KMPlaceholderTextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setUI()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionAddImages(_ sender: Any)
    {
        
    }
    
    @IBAction func actionSubmit(_ sender: UIButton)
    {
        
    }
    
    
    func setUI()
    {
        btnSubmit.backgroundColor = Appcolor.getThemeColor()
    }

}
