//
//  CustomButton.swift
//  MegaTTT
//
//  Created by Andrew Mo on 7/13/20.
//  Copyright © 2020 Andrew Mo. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor(red: 162.0/255.0, green: 166.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        titleLabel?.font = UIFont(name: "BigNoodleTitling", size: 23)
        layer.cornerRadius = frame.size.height / 2.5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3.0
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
}
