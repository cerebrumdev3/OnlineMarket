//
//  UICollectionVoew.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 3/26/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView
{
    
    func setEmptyMessage(_ message: String)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        // self.separatorStyle = .none;
    }
    
    func restore()
    {
        self.backgroundView = nil
       // self.separatorStyle = .singleLine
    }
    
    func roundCorners_TOP_LEFT_TOP_RIGHT(val:Int)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: val, height: val))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
