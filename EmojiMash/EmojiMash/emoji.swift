//
//  emoji.swift
//  EmojiMash
//
//  Created by Mihai Stoian on 25/03/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import Foundation

struct emoji
{
    var isVisible = false
    var identifier: Int
    
    static var counter = 0
    
    static func getUniqueIdentifier() -> Int
    {
        counter += 1
        return counter
    }
    init()
    {
        self.identifier = emoji.getUniqueIdentifier()
    }
}
