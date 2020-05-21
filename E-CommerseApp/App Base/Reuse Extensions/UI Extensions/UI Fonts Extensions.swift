//
//  UI Fonts Extensions.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 5/21/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation
import UIKit

typealias MainFont = Font.HelveticaNeue

enum Font {
    enum HelveticaNeue: String {
        case ultraLightItalic = "UltraLightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case ultraLight = "UltraLight"
        case italic = "Italic"
        case light = "Light"
        case thinItalic = "ThinItalic"
        case lightItalic = "LightItalic"
        case bold = "Bold"
        case thin = "Thin"
        case condensedBlack = "CondensedBlack"
        case condensedBold = "CondensedBold"
        case boldItalic = "BoldItalic"
        
        func with(size: CGFloat) -> UIFont
        {
            return UIFont(name: "HelveticaNeue-\(rawValue)", size: size)!
        }
    }
}
