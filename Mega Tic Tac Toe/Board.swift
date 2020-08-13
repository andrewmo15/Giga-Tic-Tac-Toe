//
//  Board.swift
//  MegaTTT
//
//  Created by Andrew Mo on 7/12/20.
//  Copyright © 2020 Andrew Mo. All rights reserved.
//

public class Board {
    
    private var largeBoard: [String]
    private var miniBoards: [[String]] = []
    
    public init() {
        self.largeBoard = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        for _ in 0...8 {
            self.miniBoards.append([" ", " ", " ", " ", " ", " ", " ", " ", " "])
        }
    }
    
    public func add(atIndex: Int, str: String) {
        miniBoards[atIndex / 9][atIndex % 9] = str
    }
    
    public func checkWin(ofBoard: [String]) -> Bool {
        let array = ofBoard
        if (array[0] != " " && array[0] != "T") && (array[0] == array[1]) && (array[1] == array[2]) {
            return true;
        } else if (array[3] != " " && array[3] != "T") && (array[3] == array[4]) && (array[4] == array[5]) {
            return true;
        } else if (array[6] != " " && array[6] != "T") && (array[6] == array[7]) && (array[7] == array[8]) {
            return true;
        } else if (array[0] != " " && array[0] != "T") && (array[0] == array[3]) && (array[3] == array[6]) {
            return true;
        } else if (array[1] != " " && array[1] != "T") && (array[1] == array[4]) && (array[4] == array[7]) {
            return true;
        } else if (array[2] != " " && array[2] != "T") && (array[2] == array[5]) && (array[5] == array[8]) {
            return true;
        } else if (array[0] != " " && array[0] != "T") && (array[0] == array[4]) && (array[4] == array[8]) {
            return true;
        } else if (array[2] != " " && array[2] != "T") && (array[2] == array[4]) && (array[4] == array[6]) {
            return true;
        } else {
            return false;
        }
    }
    
    public func checkTie(ofBoard: [String]) -> Bool {
        var count = 0
        for str in ofBoard {
            if str != " " {
                count += 1
            }
        }
        if count == 9 {
            return true
        } else {
            return false
        }
    }
    
    public func getLargeBoard() -> [String] {
        return self.largeBoard
    }
    
    public func getMiniBoards() -> [[String]] {
        return self.miniBoards
    }
    
    public func setLargeBoardValue(of: Int, to: String) {
        largeBoard[of] = to
    }
    
    public func setMiniBoardsValue(of: [Int], to: String) {
        miniBoards[of[0]][of[1]] = to
    }
}
