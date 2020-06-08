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
    var convertedDate : String?
    
    //MARK:- setData
    func setBanner(bannerList:Sale?){
        if let url = bannerList?.icon{
            self.imageBanner.setImage(with: url, placeholder: KDefaultIcon)
        }
        lblOffer.text = "\(bannerList?.offer ?? 0)" + "% Off"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.formatterBehavior = .default
        if  let date = dateFormatter.date(from: bannerList?.validUpto ?? ""){
            let dateTime = "\(date)"
            if let date = dateTime.components(separatedBy: "+").first
            {
                convertedDate = "\(date)"
            }
        }
        
        let dateFormatterGet = DateFormatter()
        //Fri Apr 3 2020 2:00 PM
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //MonthFormateWithDay
        let dateFormatterMonth = DateFormatter()
        //2020-03-30 14:00:00
        dateFormatterMonth.dateFormat = "hh"
        
        let mintFormate = DateFormatter()
        mintFormate.dateFormat = "mm"
        
        let secFormate = DateFormatter()
        secFormate.dateFormat = "ss"
        
        if let date = dateFormatterGet.date(from: convertedDate ?? "")
        {
            print(dateFormatterMonth.string(from: date))
            lbltime.text = dateFormatterMonth.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        if let date = dateFormatterGet.date(from: convertedDate ?? "")
        {
            print(mintFormate.string(from: date))
            lblMinutes.text = mintFormate.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        if let date = dateFormatterGet.date(from: convertedDate ?? "")
        {
            print(secFormate.string(from: date))
            lblSec.text = secFormate.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
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
