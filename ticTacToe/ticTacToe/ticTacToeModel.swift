//
//  ticTacToeModel.swift
//  ticTacToe
//
//  Created by Mihai Stoian on 29/03/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import Foundation

class ticTacToe{
    var grid = [Int?](repeating: nil, count: 9)
    
    func main(){
        
    }
    func play(type: String, position: Int){
        if type == "X"{
            grid[position] = 1
        } else{
            grid[position] = 0
        }
    }
    func checkForWin() -> String?{
        // Checking for vertical matches
        for topPos in 0...2{
            if let a = grid[topPos], let b = grid[topPos + 3], let c = grid[topPos + 6] {
                if a == b, b == c{
                    return (a == 1) ? "X" : "O"
                }
            }
        }
        // Checking for horizontal matches
        let horizontalPoses = [0,3,6]
        for horizontalPos in horizontalPoses{
            if let a = grid[horizontalPos], let b = grid[horizontalPos + 1], let c = grid[horizontalPos + 2]{
                if a == b, b == c {
                    return (a == 1) ? "X" : "O"
                }
            }
        }
        // Checking for cross matches
        if let a = grid[0], let b = grid[4], let c = grid[8]{
            if a == b, b == c {
                return (a == 1) ? "X" : "O"
            }
        }
        if let a = grid[2], let b = grid[4], let c = grid[6]{
            if a == b, b == c {
                return (a == 1) ? "X" : "O"
            }
        }
        return nil
    }
    
}
