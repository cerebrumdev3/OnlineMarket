//
//  CellClass_OrderDetails.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/3/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class CellClass_OrderDetails: UITableViewCell
{
    
    @IBOutlet var iv: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblUnits: UILabel!
    @IBOutlet var lblPrice: UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.iv.layer.cornerRadius = 10
        self.iv.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
