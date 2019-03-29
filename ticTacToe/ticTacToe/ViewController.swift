//
//  ViewController.swift
//  ticTacToe
//
//  Created by Mihai Stoian on 29/03/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        setButtonFonts()
        updateFromModel()
    }
    @IBOutlet var gridButtons: [UIButton]!
    lazy var game = ticTacToe()
    
    @IBOutlet weak var winnerLabel: UILabel!
    var nextXOinQ = "X"
    @IBAction func buttonPressed(_ sender: UIButton) {
        let buttonIndex = gridButtons.firstIndex(of: sender)!
        game.play(type: nextXOinQ, position: buttonIndex)
        if nextXOinQ == "X"{
            nextXOinQ = "O"
        }else{
            nextXOinQ = "X"
        }
        updateFromModel()
    }
    
    @IBAction func resetButonPressed(_ sender: UIButton) {
        for index in game.grid.indices{
            game.grid[index] = nil
        }
        updateFromModel()
    }
    func updateFromModel(){
        for index in gridButtons.indices{
            if let xo = game.grid[index]{
                (xo == 0) ?
                    updateTheButtonTitle(ofIndex: index, with: "O") :
                    updateTheButtonTitle(ofIndex: index, with: "X")
            } else{
                updateTheButtonTitle(ofIndex: index, with: "_")
            }
        }
        if let winner = game.checkForWin(){
            winnerLabel.text = winner + " wins!"
        }
    }
    func updateTheButtonTitle(ofIndex Index: Int, with S: String){
        gridButtons[Index].setTitle(S, for: UIControl.State.normal)
    }
    
    // MARK : SET UI
    func setButtonFonts(){
        for index in gridButtons.indices{
            gridButtons[index].titleLabel?.font = UIFont(name: "Arial-BoldItalicMT", size: 40)
        }
    }

    
}

