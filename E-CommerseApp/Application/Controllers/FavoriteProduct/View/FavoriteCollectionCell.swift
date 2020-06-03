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
    
     //MARK:-other functions
     func  setView()
     {
         lblCurrentPrice.textColor = Appcolor.klightOrangeColor
         lblDiscount.textColor = Appcolor.kRedColor
     }
    @IBAction func deleteAction(_ sender: Any){
        
    }
}

