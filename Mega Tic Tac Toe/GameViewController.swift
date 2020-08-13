//
//  GameViewController.swift
//  Mega Tic Tac Toe
//
//  Created by Andrew Mo on 7/12/20.
//  Copyright © 2020 Andrew Mo. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // setting up the background inmage
    let backgroundImageView = UIImageView()
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Background")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    // setting up the large board
    lazy var topbarHeight: CGFloat = {
        return 2.2 * ((view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0))
    }()
    
    lazy var largeVertLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: (view.frame.width * 0.02) + (0.96 * view.frame.width) / 3, y: topbarHeight, width: 0.96 * view.frame.width / 3.0, height: (0.96 * view.frame.height) - topbarHeight))
        let leftBorder = CALayer()
        let rightBorder = CALayer()
        leftBorder.frame = CGRect(x: 0, y: 0, width: 7.0, height: label.frame.height)
        rightBorder.frame = CGRect(x: label.frame.width, y: 0, width: 7.0, height: label.frame.height)
        leftBorder.backgroundColor = UIColor.black.cgColor
        rightBorder.backgroundColor = UIColor.black.cgColor
        label.layer.addSublayer(leftBorder)
        label.layer.addSublayer(rightBorder)
        return label
    }()
    
    lazy var largeHoriLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: view.frame.width * 0.02, y: topbarHeight + (largeVertLabel.frame.height) / 3.0, width: view.frame.width * 0.96, height: largeVertLabel.frame.height / 3.0))
        let topBorder = CALayer()
        let bottomBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: label.frame.width, height: 7.0)
        bottomBorder.frame = CGRect(x: 0, y: label.frame.height, width: label.frame.width, height: 7.0)
        topBorder.backgroundColor = UIColor.black.cgColor
        bottomBorder.backgroundColor = UIColor.black.cgColor
        label.layer.addSublayer(topBorder)
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    
    
    // setting up the small boards
    lazy var smallVertLabelArray: [UILabel] = {
        var array: [UILabel] = []
        for num in 0 ... 8 {
            var label = UILabel(frame: CGRect(x: largeHoriLabel.frame.origin.x + (largeVertLabel.frame.width - 6.0) / 3.0, y: largeVertLabel.frame.origin.y + 0.15 * ((largeHoriLabel.frame.height - 7.0) / 3.0), width: (largeVertLabel.frame.width - 7.0) / 3.0, height: 0.96 * (largeHoriLabel.frame.height - 7.0)))
            let leftBorder = CALayer()
            let rightBorder = CALayer()
            leftBorder.frame = CGRect(x: 0, y: 0, width: 3.0, height: label.frame.height)
            rightBorder.frame = CGRect(x: label.frame.width, y: 0, width: 3.0, height: label.frame.height)
            leftBorder.backgroundColor = UIColor.black.cgColor
            rightBorder.backgroundColor = UIColor.black.cgColor
            label.layer.addSublayer(leftBorder)
            label.layer.addSublayer(rightBorder)
            
            if num / 3 == 1 {
                label.frame.origin.y += label.frame.height + 7.0 + 0.04 * ((largeVertLabel.frame.height / 3.0) - 7.0)
            }
            if num / 3 == 2 {
                label.frame.origin.y += 2 * (label.frame.height + 7.0 + 0.04 * ((largeVertLabel.frame.height / 3.0) - 7.0))
            }
            if num % 3 == 1 {
                label.frame.origin.x += (largeHoriLabel.frame.width) / 3.0 + 7.0 + 0.04 * ((largeVertLabel.frame.width / 3.0) - 7.0)
            }
            if num % 3 == 2 {
                label.frame.origin.x += (2.0 * largeHoriLabel.frame.width) / 3.0 + 7.0 + 0.04 * ((largeVertLabel.frame.width / 3.0) - 7.0)
            }
            array.append(label)
        }
        return array
    }()
    
    lazy var smallHoriLabelArray: [UILabel] = {
        var array: [UILabel] = []
        for num in 0 ... 8 {
            var label = UILabel(frame: CGRect(x: largeHoriLabel.frame.origin.x + (largeHoriLabel.frame.width * 0.01), y: smallVertLabelArray[num].frame.origin.y + smallVertLabelArray[num].frame.height / 3.0, width: 0.96 * (largeVertLabel.frame.width - 7.0), height: smallVertLabelArray[num].frame.height / 3.0))
            let topBorder = CALayer()
            let bottomBorder = CALayer()
            topBorder.frame = CGRect(x: 0, y: 0, width: label.frame.width, height: 3.0)
            bottomBorder.frame = CGRect(x: 0, y: label.frame.height, width: label.frame.width, height: 3.0)
            topBorder.backgroundColor = UIColor.black.cgColor
            bottomBorder.backgroundColor = UIColor.black.cgColor
            label.layer.addSublayer(topBorder)
            label.layer.addSublayer(bottomBorder)
            
            if num % 3 == 1 {
                label.frame.origin.x += (largeHoriLabel.frame.width) / 3.0 + 7.0
            }
            if num % 3 == 2 {
                label.frame.origin.x += (2.0 * largeHoriLabel.frame.width) / 3.0 + 9.0
            }
            array.append(label)
        }
        return array
    }()
    
    // setting up buttons
    lazy var buttons: [UIButton] = {
        var array: [UIButton] = []
        var count = 0
        for num in 0 ... 80 {
            var button = UIButton.init(type: .system)
            button.frame = CGRect(x: smallHoriLabelArray[num / 9].frame.origin.x, y: smallVertLabelArray[num / 9].frame.origin.y, width: smallHoriLabelArray[num / 9].frame.width / 3.0, height: smallVertLabelArray[num / 9].frame.height / 3.0)
            button.setTitle(" ", for: .normal)
            button.tintColor = .black
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            button.tag = num
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            if num % 3 == 1 {
                button.frame.origin.x += smallHoriLabelArray[num / 9].frame.width / 3.0
            }
            if num % 3 == 2 {
                button.frame.origin.x += 2 * smallHoriLabelArray[num / 9].frame.width / 3.0
            }
            if (num - (count * 9)) / 3 == 1 {
                button.frame.origin.y += smallVertLabelArray[num / 9].frame.height / 3.0
            }
            if (num - (count * 9)) / 3 == 2 {
                button.frame.origin.y += 2 * smallVertLabelArray[num / 9].frame.height / 3.0
            }
            if num != 0 && num % 9 == 0 {
                count += 1
            }
            array.append(button)
        }
        return array
    }()
    
    // setting up large labels
    lazy var labels: [UILabel] = {
        var array: [UILabel] = []
        for num in 0 ... 8 {
            var label = UILabel(frame: CGRect(x: smallHoriLabelArray[num].frame.origin.x, y: smallVertLabelArray[num].frame.origin.y, width: smallHoriLabelArray[num].frame.width, height: smallVertLabelArray[num].frame.height))
            label.text = " "
            label.textAlignment = .center
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: (3.0 * view.frame.width) / 8.0)
            label.adjustsFontSizeToFitWidth = true
            array.append(label)
        }
        return array
    }()
    
    // setting up game
    var board = Board()
    var player = 1
    var currentIndex = 4
    var game = true
    var available = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    let boardNames = ["top left", "top center", "top right", "center left", "very center", "center right", "bottom left", "bottom center", "bottom right"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        self.view.addSubview(largeHoriLabel)
        self.view.addSubview(largeVertLabel)
        for num in 0 ..< smallVertLabelArray.count {
            self.view.addSubview(labels[num])
            self.view.addSubview(smallVertLabelArray[num])
            self.view.addSubview(smallHoriLabelArray[num])
        }
        for num in 0 ..< buttons.count {
            self.view.addSubview(buttons[num])
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undo))
        self.title = "Player \(player)'s turn!"
        labels[currentIndex].backgroundColor = UIColor.white.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
    }
    
    // Setting up undo process
    var stack = LinkedStack()
    
    @objc func undo() {
        if (stack.getHead() != nil) {
            let prev = stack.pop()
            buttons[prev!.getData()].setTitle(" ", for: UIControl.State())
            board.setMiniBoardsValue(of: [prev!.getData() / 9, prev!.getData() % 9], to: " ")
            labels[currentIndex].backgroundColor = UIColor.clear
            currentIndex = prev!.getCurrentIndex()
            labels[currentIndex].backgroundColor = UIColor.white.withAlphaComponent(0.7)
            if player == 1 {
                player = 2
            } else {
                player = 1
            }
            self.title = "Player \(player)'s turn!"
            if prev?.getLargeLabel() != nil {
                labels[(prev?.getLargeLabel())!].text = " "
                board.setLargeBoardValue(of: currentIndex, to: " ")
                available.append(currentIndex)
            }
            game = true
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if game && board.getLargeBoard()[sender.tag / 9] == " " && (sender.tag / 9 == currentIndex) && (sender.currentTitle == " ") {
            var str: String
            if player == 1 {
                sender.setTitle("X", for: UIControl.State())
                board.add(atIndex: sender.tag, str: "X")
                player = 2
                str = "X"
            } else {
                sender.setTitle("O", for: UIControl.State())
                board.add(atIndex: sender.tag, str: "O")
                player = 1
                str = "O"
            }
            if board.checkWin(ofBoard: board.getMiniBoards()[currentIndex]) {
                board.setLargeBoardValue(of: currentIndex, to: str)
                labels[currentIndex].text = str
                removeFromAvailable()
                stack.push(data: sender.tag, largeLabel: currentIndex, currentIndex: currentIndex)
            } else if board.checkTie(ofBoard: board.getMiniBoards()[currentIndex]) {
                labels[currentIndex].text = "T"
                board.setLargeBoardValue(of: currentIndex, to: "T")
                removeFromAvailable()
                stack.push(data: sender.tag, largeLabel: currentIndex, currentIndex: currentIndex)
            } else {
                stack.push(data: sender.tag, largeLabel: nil, currentIndex: currentIndex)
            }
            labels[currentIndex].backgroundColor = UIColor.clear
            currentIndex = sender.tag % 9
            if board.checkWin(ofBoard: board.getLargeBoard()) {
                game = false
                var winAlert: UIAlertController
                if player == 1 {
                    self.title = "Congrats Player 2!!!"
                    winAlert = UIAlertController(title: "Player 2 won!!!", message: "Press the back button to exit", preferredStyle: .alert)
                } else {
                    self.title = "Congrats Player 1!!!"
                    winAlert = UIAlertController(title: "Player 1 won!!!", message: "Press the back button to exit", preferredStyle: .alert)
                }
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                winAlert.addAction(okAction)
                present(winAlert, animated: true, completion: nil)
            } else if board.checkTie(ofBoard: board.getLargeBoard()) {
                game = false
                let winAlert = UIAlertController(title: "It's a tie...", message: "Press the back button to exit", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                winAlert.addAction(okAction)
                present(winAlert, animated: true, completion: nil)
                self.title = "It's a tie..."
            } else if !available.contains(currentIndex) {
                currentIndex = available[Int.random(in: 0...(available.count - 1))]
                let alert = UIAlertController(title: "Random box!", message: "Go to the \(boardNames[currentIndex]) box now!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                self.title = "Player \(player)'s turn!"
                labels[currentIndex].backgroundColor = UIColor.white.withAlphaComponent(0.7)
            } else {
                self.title = "Player \(player)'s turn!"
                labels[currentIndex].backgroundColor = UIColor.white.withAlphaComponent(0.7)
            }
        }
    }
    
    private func removeFromAvailable() {
        for num in 0...(available.count - 1) {
            if available[num] == currentIndex {
                available.remove(at: num)
                break
            }
        }
    }
}
