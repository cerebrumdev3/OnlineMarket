//
//  FilterCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {
 //MARK:- Outlet and variables 
    @IBOutlet weak var imgDownArrow: UIImageView!
    @IBOutlet weak var lblFilterType: UILabel!
    @IBOutlet weak var viewBack: CustomUIView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
       }
}
