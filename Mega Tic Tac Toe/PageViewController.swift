//
//  PageViewController.swift
//  MegaTTT
//
//  Created by Andrew Mo on 7/10/20.
//  Copyright © 2020 Andrew Mo. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    let images: [UIImage] = [UIImage(named: "Instructions1")!, UIImage(named: "Instructions2")!, UIImage(named: "Instructions3")!, UIImage(named: "Instructions4")!, UIImage(named: "Instructions5")!, UIImage(named: "Instructions6")!,]
    let text: [String] = ["The goal of this game is to get 3 in a row (up, down, across, or diagonally) on the large tic-tac-toe map. Notice how there is a large tic-tac-toe board and within each square, there is a smaller tic-tac-toe board.", "The game starts in the middle in the very center board. The first player marks an X anywhere on this center board. But wherever player 1 marks is the board that player 2 (who marks O) has to transition to.", "For example, in the picture above, player 2 marked the top left corner of the center board. Now player 1 has to make his move somewhere on the top left board of the entire board.", "If a player wins a subboard, then that player claims that square on the entire board. Again, the first person to get three in a row on the large board wins the game.", "If no one wins a subboard, then it will be marked with a 'T', denoting a tie. This means that this square will not be awarded to anyone, so you must use other squares to get three-in-a-row.", "If a player selects a square on the subboard that corresponds to a square that's already filled on the larger board, then a random square is chosen. An alert will pop up to guide you to the correct square."]
    
    lazy var orderedViewControllers: [UIViewController] = {
        var array: [UIViewController] = []
        for num in 1 ... images.count {
            let page: UIViewController = self.newVC(viewController: String(num))
            page.view.backgroundColor = UIColor.clear
            let label = UILabel(frame: CGRect(x: 15, y: page.view.frame.height * 0.6, width: page.view.frame.width - 30, height: page.view.frame.height * 0.3))
            label.numberOfLines = 6
            label.text = text[num - 1]
            label.font = UIFont(name: "BigNoodleTitling", size: page.view.frame.height / 30)
            label.textColor = .black
            label.textAlignment = .center
            
            let imageView = UIImageView(image: images[num - 1])
            imageView.frame = CGRect(x: 0.25 * page.view.frame.width, y: page.view.frame.height * 0.1, width: 0.5 * page.view.frame.width, height: page.view.frame.height / 2.0)
            page.view.addSubview(imageView)
            page.view.addSubview(label)
            array.append(page)
        }
        return array
    }()
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor(red: 211.0/255.0, green: 155.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.delegate = self
        configurePageControl()
        setBackground()
        // Do any additional setup after loading the view.
    }
    
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

}
