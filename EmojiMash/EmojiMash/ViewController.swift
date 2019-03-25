//
//  ViewController.swift
//  EmojiMash
//
//  Created by Mihai Stoian on 25/03/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad() {
        updateFromModel()
        runTimer()
    }
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var hitsLabel: UILabel!
    @IBOutlet weak var missedLabel: UILabel!
    var missedCount = 0
    func missedLabelIncrement()
    {
        
        missedCount += 1
        missedLabel.text = "Missed: \(missedCount)"
    }
    lazy var game = emojiMash( with: buttonsCollection.count )
    
    var hitsCount = 1
    @IBAction func emojiPressed(_ sender: UIButton)
    {
        if let emojiIndex = buttonsCollection.index(of: sender)
        {
            if game.IsVisibleEmoji(at: emojiIndex)
            {
                game.chooseEmoji(at: emojiIndex)
                hitsLabel.text = "Hits: \(hitsCount)"
                hitsCount += 1
            }
        }
        updateFromModel()
    }
    
    func updateFromModel()
    {
        for index in buttonsCollection.indices
        {
            let Button = buttonsCollection[index]
            let emoji = game.emojis[index]
            if emoji.isVisible == true
            {
                let emojiStr = getRandomEmoji(at: index)
                Button.setTitle(emojiStr, for: UIControl.State.normal)
        
            } else
            {
                Button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    func runTimer() {
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self,   selector: (#selector(ViewController.chooseRandomEmoji)), userInfo: nil, repeats: true)
    }
    
    @objc func chooseRandomEmoji()
    {
        let randomIndex = Int.random(in: 0..<buttonsCollection.count)
        if !game.IsVisibleEmoji(at: randomIndex)
        {
            game.chooseEmoji(at: randomIndex)
            updateFromModel()
            distroyEmoji(after: 1.0, at: randomIndex)
            
        }
    }
    
    func distroyEmoji(after deadline: Double, at Index: Int)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if self.game.IsVisibleEmoji(at: Index)
            {
                self.game.chooseEmoji(at: Index)
                self.updateFromModel()
                self.missedLabelIncrement()
            }
        })
    }
    func getRandomEmoji(at Index: Int) -> String
    {
        var emojiArr = ["😀","😇","🦋","🐮","🐔","🐞","✈️","🚔","🚲","🚓","🛰","🚥","📴","🔎","🤬","😡","🧐","🤖","😻","👩‍🏭","🍝","🥐","🥡"]
        return String(emojiArr[Index % emojiArr.count])
    }
    

}
