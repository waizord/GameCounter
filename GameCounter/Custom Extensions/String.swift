//
//  String.swift
//  GameCounter
//
//  Created by Ivan on 8/31/21.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
