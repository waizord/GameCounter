//
//  Player.swift
//  GameCounter
//
//  Created by Ivan on 8/28/21.
//

import Foundation
class Player {
    var name: String = ""
    let result: Int? = nil
    let lastResult: Int? = nil
    var firstSimbol: String = ""
    
    init(name: String) {
        self.name = name
        self.firstSimbolName()
    }
    
    private func firstSimbolName() {
        if let char = name.first {
            self.firstSimbol = String(char)
        }
    }
}
