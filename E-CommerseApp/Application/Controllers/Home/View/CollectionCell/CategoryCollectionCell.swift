//
//  CategoryCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    //MARK:- other Functions
    func setView(categoryList:CategoryElement?)
    {
        self.viewBack.layer.borderWidth = 1
      //  self.imgView.backgroundColor = .white
    //self.imgView.layer.borderColor = Appcolor.klightBlueColor.cgColor
//        self.imgView.layer.masksToBounds = true
//    self.imgView.layer.cornerRadius = self.imgView.frame.height/2
       self.viewBack.layer.borderColor = Appcolor.klightBlueColor.cgColor
        self.viewBack.layer.cornerRadius = self.viewBack.frame.height/2
         self.viewBack.layer.masksToBounds = true
        
        //setData
        if let url = categoryList?.icon{
                 self.imgView.setImage(with: url, placeholder: KDefaultIcon)
        }
        lblName.text = categoryList?.name ?? ""
    }
}
