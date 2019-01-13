//
//  Card.swift
//  Concentration
//
//  Created by Yuzhou Cheng on 1/7/19.
//  Copyright © 2019 Yuzhou Cheng. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatch = false
    var identifier: Int

    static var uid = 0

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func getUniqueIdentifier() -> Int {
        uid += 1
        return uid
    }
}
