//
//  MiddleBannerCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class MiddleBannerCollectionCell: UICollectionViewCell {
    //MARK:- Outlet and Variales
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblMiddle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    func setView(recommendedList:Recommended?){
        if let url = recommendedList?.thumbnail{
           self.imgView.setImage(with: url, placeholder: KDefaultIcon)
        }
    }
}
