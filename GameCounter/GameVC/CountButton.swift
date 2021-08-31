//
//  CountButton.swift
//  GameCounter
//
//  Created by Ivan on 8/31/21.
//

import Foundation
import UIKit

class CountButton: UIButton {
    var countTitle: Int = 0
    
    func configure(_ size: CGSize, _ title: String, _ fontSize: CGFloat) {
        self.backgroundColor = Constants.colors.customGreen
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: fontSize)
        self.titleLabel?.textColor = .white
        self.layer.cornerRadius = 23
        self.clipsToBounds = true
        
        self.countTitle = NSString(string: title).integerValue
        
    }

}
