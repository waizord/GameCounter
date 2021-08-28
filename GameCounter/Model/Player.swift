//
//  Player.swift
//  GameCounter
//
//  Created by Ivan on 8/28/21.
//

import Foundation
class Player: NSObject {
    let name: String = ""
    let result: Int? = nil
    let lastResult: Int? = nil
    var firstSimbol: String = ""
    
    func firstSimbolName() {
        if let char = name.first {
            self.firstSimbol = String(char)
        }
    }
    override init() {
        super.init()
        firstSimbolName()
    }
}
