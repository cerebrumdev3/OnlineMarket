//
//  FlashSaleCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class FlashSaleCollectionCell: UICollectionViewCell {
    
    //MARK:- Outlet and Variables 
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblCurrentPrice: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    func  setView(saleList:Sale?,currency:String?)
    {
        lblCurrentPrice.textColor = Appcolor.klightOrangeColor
        lblDiscount.textColor = Appcolor.kRedColor
        
        if let url = saleList?.icon{
            self.imgView.setImage(with: url, placeholder: KDefaultIcon)
        }
        lblServiceName.text = saleList?.name ?? ""
        lblDiscount.text = "\(saleList?.offer ?? 0)% off"
        lblCurrentPrice.text = (currency ?? "") + (saleList?.price ?? "")
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (currency ?? "") + (saleList?.originalPrice ?? ""))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        self.lblTotalPrice.attributedText = attributeString
        
    }
    
    func setDetailView(saleList:Recommended1?){
        lblCurrentPrice.textColor = Appcolor.klightOrangeColor
               lblDiscount.textColor = Appcolor.kRedColor
               
               if let url = saleList?.icon{
                   self.imgView.setImage(with: url, placeholder: KDefaultIcon)
               }
               lblServiceName.text = saleList?.name ?? ""
               lblDiscount.text = "\(saleList?.offer ?? 0)% off"
               lblCurrentPrice.text = "$" + (saleList?.price ?? "")
               
               let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$ \(saleList?.originalPrice ?? "")")
               attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
               
               self.lblTotalPrice.attributedText = attributeString
    }
}
