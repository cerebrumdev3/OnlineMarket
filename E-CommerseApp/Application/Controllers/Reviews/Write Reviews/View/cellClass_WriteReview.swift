//
//  cellClass_WriteReview.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/3/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class cellClass_WriteReview: UICollectionViewCell
{
    @IBOutlet var iv: UIImageView!
    @IBOutlet var btnDelete: UIButton!
    
    override func awakeFromNib()
    {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = Appcolor.kTextColorGray.cgColor
        self.layer.borderWidth = 1
    }
    
}
