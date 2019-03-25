//
//  emojiMash.swift
//  EmojiMash
//
//  Created by Mihai Stoian on 25/03/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import Foundation

class emojiMash
{
    var emojis = [emoji]()
    
    func chooseEmoji(at Index: Int)
    {
        if emojis[Index].isVisible == false
        {
            emojis[Index].isVisible = true
        } else
        {
            emojis[Index].isVisible = false
        }
    }
    
    func IsVisibleEmoji(at Index: Int) -> Bool
    {
        return emojis[Index].isVisible
    }
    
    init(with numberOfemojis: Int)
    {
        for _ in 1...numberOfemojis
        {
            let oneEmoji = emoji()
            emojis.append(oneEmoji)
            
        }
        // randomizing the emojis
        var schEmojis = [emoji]()
        while !emojis.isEmpty
        {
            let randomIndex = Int.random(in: 0..<emojis.count)
            schEmojis.append(emojis[randomIndex])
            emojis.remove(at: randomIndex)
        }
        emojis = schEmojis
    }
}

