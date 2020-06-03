//
//  AppColor.swift
//  GoodsDelivery
//
//  Created by Gurleen Osahan on 11/29/19.
//  Copyright © 2019 Seasia infotech. All rights reserved.
//

import Foundation
import UIKit


class Appcolor : UIViewController
{
    
    static let kTextColorWhite = UIColor.init(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    static let kTextColorBlack = UIColor.init(red: 0.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    static let kTextColorGrayDark = UIColor.init(red: 67.0/255.0, green: 67/255.0, blue: 67/255.0, alpha: 1.0)
    static let kTextColorGray = UIColor.init(red: 154.0/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1.0)
    
    static let kNavBarColor = UIColor.init(red: 247.0/255.0, green: 84.0/255.0, blue: 105.0/255.0, alpha: 1.0)//Saffron for now
    static let kDefaultTintColorBlue = UIColor.init(red: 2.0/255.0, green: 190.0/255.0, blue: 170.0/255.0, alpha: 1.0)//blue default
    
    static let kTextFieldBackgroundColor = UIColor.init(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)//Gray
    static let kButtonBackgroundColor = kTheme_Color
    
    static var kTheme_Color = UIColor.init(red: 255.0/255.0, green: 164.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    
    static var klightOrangeColor = UIColor.init(red: 255.0/255.0, green: 183.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    static var kRedColor = UIColor.init(red: 255.0/255.0, green: 98.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    static var klightBlueColor = UIColor.init(red: 235.0/255.0, green: 239.0/255.0, blue: 255/255.0, alpha: 1.0)
    static var kSelectedBlueColor = UIColor.init(red: 65.0/255.0, green: 200.0/255.0, blue: 255/255.0, alpha: 1.0)
    static var ktextGrayColor = UIColor.init(red: 158.0/255.0, green: 164.0/255.0, blue: 189/255.0, alpha: 1.0)
    static var kbtnlightOrangeColor = UIColor.init(red: 255.0/255.0, green: 242.0/255.0, blue: 228/255.0, alpha: 1.0)
    class func update_ThemeColor()
    {
        kTheme_Color = AppDefaults.shared.categoryTheme
    }
    
    class func getThemeColor()-> UIColor
    {
        return kTheme_Color
    }
    
    
}

class colorHandler
{
    class func set_button_image_with_color_change(imgName:String,button:UIButton,colorApproach:UIColor)
    {
        let origImage = UIImage(named: imgName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = colorApproach
    }
    
    class func set_button_BG_image_with_color_change(imgName:String,button:UIButton,colorApproach:UIColor)
    {
        let origImage = UIImage(named: imgName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintedImage, for: .normal)
        button.tintColor = colorApproach
    }
    
    class func set_image_with_color_change(imgName:String,imgView:UIImageView,colorApproach:UIColor) -> UIImageView
    {
        if let myImage = UIImage(named: imgName)
        {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imgView.image = tintableImage
            imgView.tintColor = colorApproach
            return imgView
        }
        return UIImageView()
    }
}

extension CGFloat
{
    static func random() -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor
{
    static func random() -> UIColor
    {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}


@IBDesignable
class GradientView: UIView
{
    
    @IBInspectable var startColor:   UIColor = UIColor(red: 255.0/255.0, green: 164.0/255.0, blue: 42.0/255.0, alpha: 1.0) { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = UIColor(red: 255.0/255.0, green: 122.0/255.0, blue: 0.0/255.0, alpha: 1.0) { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints()
    {
        if horizontalMode
        {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        }
        else
        {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations()
    {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors()
    {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
