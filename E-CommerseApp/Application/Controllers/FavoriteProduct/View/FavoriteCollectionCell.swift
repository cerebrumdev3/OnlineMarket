//
//  FavoriteCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import Cosmos

class FavoriteCollectionCell: UICollectionViewCell
{
    //MARK:- outlet and VAriables
     @IBOutlet weak var lblTotalPrice: UILabel!
     @IBOutlet weak var lblDiscount: UILabel!
     @IBOutlet weak var lblCurrentPrice: UILabel!
     @IBOutlet weak var viewRating: CosmosView!
     @IBOutlet weak var lblServiceNAme: UILabel!
     @IBOutlet weak var imgView: UIImageView!
     @IBOutlet weak var viewBAck: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var viewDalaget:FavoriteViewDelegate?
    
     //MARK:-other functions
    func  setView(data:Body16?)
     {
         lblCurrentPrice.textColor = Appcolor.klightOrangeColor
         lblDiscount.textColor = Appcolor.kRedColor
        
        //setData
             imgView.layer.cornerRadius = 8
        if let url = data?.product?.thumbnail{
                         self.imgView.setImage(with: url, placeholder: KDefaultIcon)
                     }
              lblServiceNAme.text = data?.product?.name ?? ""
               // viewRating.rating = Double(data?.rating ?? 0)
              lblDiscount.text = "\(data?.product?.offer ?? 0)% off"
                lblCurrentPrice.text = ("$")+(data?.product?.price ?? "0")
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: ("$")+(data?.product?.originalPrice ?? ""))
                       attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                       
                       self.lblTotalPrice.attributedText = attributeString
     }
    @IBAction func deleteAction(_ sender: Any)
    {
        viewDalaget?.removeFromFavorite(index:(sender as AnyObject).tag)
    }
}

