//
//  CategoryListCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 26/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class CategoryListCell: UITableViewCell {

    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK:- Other functions
    func setView(categoryList:Service?){
        lblNAme.text = categoryList?.name ?? ""
        if let url = categoryList?.icon{
            self.imageViewIcon.setImage(with: url, placeholder: KDefaultIcon)
         }
    }
}
