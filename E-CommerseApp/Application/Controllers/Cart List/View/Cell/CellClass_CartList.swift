//
//  CellClass_CartList.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 4/1/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit
import Cosmos

class CellClass_CartList: UITableViewCell
{
    
    @IBOutlet var iv: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnFav: UIButton!
    @IBOutlet var viewBG: UIView!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.viewBG.layer.cornerRadius = 10
        self.viewBG.layer.borderColor = Appcolor.kTextColorGrayDark.cgColor
        self.viewBG.layer.borderWidth = 0.5
        iv.CornerRadius(radius: 8)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

    
    func hideAnimation()
    {
        [self.iv,self.btnFav,self.lblName,self.lblPrice,self.btnDelete,self.btnDelete].forEach
        {
            $0?.hideSkeleton()
        }
    }
    
    func showAnimation()
    {
        [self.iv,self.btnFav,self.lblName,self.lblPrice,self.btnDelete,self.btnDelete].forEach
        {
            $0?.showAnimatedGradientSkeleton()
        }
    }
    
}
