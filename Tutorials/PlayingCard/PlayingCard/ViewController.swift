//
//  ViewController.swift
//  PlayingCard
//
//  Created by Mihai Stoian on 31/03/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet{
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard)) // Swipe gesture
            swipe.direction = [.left,.right]
            playingCardView.addGestureRecognizer(swipe)
        }
    }
    @objc func nextCard(){
        if let card = deck.draw(){
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) { // Tap gesture
        playingCardView.isFaceUp = !playingCardView.isFaceUp
    }
    func debugCode(){
        for _ in 1...10{
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    
        
    
    func viewDidLoad() {
        super.viewDidLoad()
        
        }
    }


}

