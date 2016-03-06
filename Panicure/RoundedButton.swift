//
//  RoundedButton.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

@objc(EVARoundedButton)
class RoundedButton: UIControl {

    var redColor: UIColor!// = UIColor.eva_mainRedColor()
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    
    private func setUp() {
        layer.borderColor = redColor.CGColor
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    
    private func setupLabel() {
        label = UILabel()
        label.font = UIFont(name: "SF UI Display", size: 18.0)
        label.textColor = redColor
    }
    
    private func updateFill() {
        if filled {
            backgroundColor = redColor
            
        }
    }
    
    var filled: Bool = false {
        didSet {
            updateFill()
        }
    }
}
