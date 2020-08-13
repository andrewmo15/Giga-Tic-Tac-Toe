//
//  LinkedStack.swift
//  Mega Tic Tac Toe
//
//  Created by Andrew Mo on 7/29/20.
//  Copyright © 2020 Andrew Mo. All rights reserved.
//

public class LinkedStack {
    
    private var head: LinkedNode?
    private var size: Int
    
    public init() {
        head = nil
        size = 0
    }
    
    public func push(data: Int, largeLabel: Int?, currentIndex: Int) {
        if size == 0 {
            head = LinkedNode(data: data, next: nil, largeLabel: largeLabel, currentIndex: currentIndex)
        } else {
            head = LinkedNode(data: data, next: head!, largeLabel: largeLabel, currentIndex: currentIndex)
        }
        size += 1
    }
    
    public func pop() -> LinkedNode? {
        let thing = head!
        head = head!.getNext()
        size -= 1
        return thing
    }
    
    public func getHead() -> LinkedNode? {
        return head
    }
}
