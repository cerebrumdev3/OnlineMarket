//
//  ProductImagesCollectionCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class ProductImagesCollectionCell: UICollectionViewCell {
    //MARK:- outlet and variables
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK:- other functions
    func setView(){
        imgView.CornerRadius(radius: 4)
    }
    
}
