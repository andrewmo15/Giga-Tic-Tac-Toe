//
//  LinkedNode.swift
//  Mega Tic Tac Toe
//
//  Created by Andrew Mo on 7/29/20.
//  Copyright © 2020 Andrew Mo. All rights reserved.
//

public class LinkedNode {
    private var data: Int // data is the button.tag
    private var next: LinkedNode?
    private var largeLabel: Int?
    private var currentIndex: Int
        
    public init(data: Int, next: LinkedNode?, largeLabel: Int?, currentIndex: Int) {
        self.data = data
        self.next = next
        self.largeLabel = largeLabel
        self.currentIndex = currentIndex
    }
    
    public func getData() -> Int {
        return data
    }
    
    public func getNext() -> LinkedNode? {
        return next
    }
    
    public func getLargeLabel() -> Int? {
        return largeLabel
    }
    
    public func getCurrentIndex() -> Int {
        return currentIndex
    }
}
