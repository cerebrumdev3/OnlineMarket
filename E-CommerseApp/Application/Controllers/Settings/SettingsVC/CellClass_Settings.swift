//
//  CellClass_Settings.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/21/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class CellClass_Settings: UITableViewCell
{

    @IBOutlet var lblText: UILabel!
    @IBOutlet var btnTapOnCell: UIButton!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
