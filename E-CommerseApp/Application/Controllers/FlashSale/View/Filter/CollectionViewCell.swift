//
//  CollectionViewCell.swift
//  DynamicHeightCollectionView
//
//  Created by Payal Gupta on 11/02/19.
//  Copyright © 2019 Payal Gupta. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var kImgWidth: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imgTick: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel.text = nil
        self.layer.cornerRadius = layer.frame.height/2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
    }
}
