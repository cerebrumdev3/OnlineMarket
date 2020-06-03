//
//  SelectSizeCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class SelectSizeCollectionCell: UICollectionViewCell {
    //MARK:- outlet and variables
    @IBOutlet weak var viewBack: CustomUIView!
    @IBOutlet weak var lblSize: UILabel!
    
    //MARK:- other Functions
    func setView(sizeArray:StockQunatity11?){
        self.viewBack.layer.borderWidth = 1
        //  self.imgView.backgroundColor = .white
        self.viewBack.layer.borderColor = Appcolor.klightBlueColor.cgColor
        self.viewBack.layer.masksToBounds = true
        self.viewBack.layer.cornerRadius = self.viewBack.frame.height/2
        
        if sizeArray?.isSizeSelected == true{
            self.viewBack.layer.borderColor = Appcolor.kSelectedBlueColor.cgColor
        }else{
            self.viewBack.layer.borderColor = Appcolor.klightBlueColor.cgColor
        }
        
        //setData
        lblSize.text = sizeArray?.size ?? ""
    }
}
