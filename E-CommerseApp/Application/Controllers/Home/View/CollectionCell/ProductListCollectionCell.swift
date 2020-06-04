//
//  ProductListCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import Cosmos

class ProductListCollectionCell: UICollectionViewCell {
    //MARK:- outlet and VAriables
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblCurrentPrice: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblServiceNAme: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewBAck: UIView!
    
    //MARK:-other functions
    
    func  setView(recommendedList:Recommended?,curency:String?)
    {
      lblCurrentPrice.textColor = Appcolor.klightOrangeColor
      lblDiscount.textColor = Appcolor.kRedColor
      imgView.layer.cornerRadius = 8
      if let url = recommendedList?.thumbnail{
                 self.imgView.setImage(with: url, placeholder: KDefaultIcon)
             }
      lblServiceNAme.text = recommendedList?.name ?? ""
        viewRating.rating = Double(recommendedList?.rating ?? 0)
      lblDiscount.text = "\(recommendedList?.offer ?? 0)% off"
        lblCurrentPrice.text = (curency ?? "")+(recommendedList?.price ?? "0")
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (curency ?? "")+(recommendedList?.originalPrice ?? ""))
               attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
               
               self.lblTotalPrice.attributedText = attributeString
    }
    
    func  setSaleData(recommendedList:Service1?,curency:String?)
       {
         lblCurrentPrice.textColor = Appcolor.klightOrangeColor
         lblDiscount.textColor = Appcolor.kRedColor
        imgView.layer.cornerRadius = 8
         if let url = recommendedList?.thumbnail{
                    self.imgView.setImage(with: url, placeholder: KDefaultIcon)
                }
         lblServiceNAme.text = recommendedList?.name ?? ""
           viewRating.rating = Double(recommendedList?.rating ?? 0)
         lblDiscount.text = "\(recommendedList?.offer ?? 0)% off"
           lblCurrentPrice.text = (curency ?? "")+(recommendedList?.price ?? "0")
           let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (curency ?? "")+(recommendedList?.originalPrice ?? ""))
                  attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                  
                  self.lblTotalPrice.attributedText = attributeString
       }
}
