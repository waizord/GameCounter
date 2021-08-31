//
//  Custom Extensions.swift
//  GameCounter
//
//  Created by Ivan on 8/31/21.
//

import Foundation
import UIKit

extension UIImageView {
    func tint(color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
