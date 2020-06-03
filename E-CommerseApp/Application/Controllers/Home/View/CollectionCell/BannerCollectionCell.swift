//
//  BannerCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell {
    
    //MARK:- outlet and Variables
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblMinutes: UILabel!
    @IBOutlet weak var lblSec: UILabel!
    
    //MARK:- setData
    func setBanner(bannerList:Sale?){
        if let url = bannerList?.icon{
            self.imageBanner.setImage(with: url, placeholder: KDefaultIcon)
        }
    }
    //setBannerFor Sale
    func setFlashBanner(bannerList:Sale1?){
        if let url = bannerList?.icon{
            self.imageBanner.setImage(with: url, placeholder: KDefaultIcon)
        }
    }
    
    //setBannerFor Detail
    func setProductImages(images:String?){
        
        if let url = images{
            self.imageBanner.setImage(with: url, placeholder: KDefaultIcon)
        }    }
}
