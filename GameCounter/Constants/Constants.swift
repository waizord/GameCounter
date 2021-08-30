//
//  Constants.swift
//  GameCounter
//
//  Created by Ivan on 8/28/21.
//

import Foundation
import UIKit
class Constants {
    static var share = Constants()
    static var colors = Colors()
    let playerHeaderHeight: CGFloat = 43
    let playerFooterHeight: CGFloat = 59
    let playerCellHeight: CGFloat = 54
    let startButtonHeight: CGFloat = 60
    
    struct Colors {
        let appBackgroundBlack = UIColor(red: 0.136, green: 0.136, blue: 0.136, alpha: 1)
        let customBackgroundGray = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        let customTextGray = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        let customGreen = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        let customShadowGreen = UIColor(red: 84.0/255.0, green: 120.0/255.0, blue: 111.0/255.0, alpha: 1)
        let customRed = UIColor(red: 0.925, green: 0.369, blue: 0.376, alpha: 1)
        let customPlayerTableSeparator = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        let customPlaceHolder = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 161.0/255.0, alpha: 1)
        
    }
}
