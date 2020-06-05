//
//  SelectColorCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class SelectColorCollectionCell: UICollectionViewCell {
    @IBOutlet weak var viewColor: CustomUIView!
    
    //MARK:- other Functions
    func setView(colorList:ProductSpecification11?)
    {
        //setView
     self.viewColor.layer.masksToBounds = true
     self.viewColor.layer.cornerRadius = self.viewColor.frame.height/2
        
        //setdata
       viewColor.backgroundColor = UIColor(hexString: colorList?.productColor ?? "0")//UIColor.init(netHex: Int(colorList?.productColor ?? "0") ?? 0)//colorList?.productColor
        
        if colorList?.isColorSelected == true{
           viewColor.layer.borderWidth = 3
           viewColor.layer.borderColor = Appcolor.kTheme_Color.cgColor
        }else{
            viewColor.layer.borderWidth = 0
        }
        
     }
}
