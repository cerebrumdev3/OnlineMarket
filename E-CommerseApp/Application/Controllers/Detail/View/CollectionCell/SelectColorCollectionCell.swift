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
    func setView(colorList:ProductSpecification12?)
    {
        //setView
     self.viewColor.layer.masksToBounds = true
     self.viewColor.layer.cornerRadius = self.viewColor.frame.height/2
        
        //setdata
        viewColor.backgroundColor = UIColor.init(netHex: Int(colorList?.productColor ?? "0") ?? 0)//colorList?.productColor
        
     }
}
