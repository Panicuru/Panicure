//
//  RoundedButton.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import PureLayout

@objc(EVARoundedButton)
class RoundedButton: UIControl {

    
    var fillColor: UIColor = UIColor.eva_mainRedColor()
    var label: UILabel!
    @IBInspectable var text: String? {
        didSet {
            label.text = text
        }
    }
    var filled: Bool = false {
        didSet {
            updateFill()
        }
    }
   
    // MARK: -
    // MARK: - SetUp
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    
    private func setUp() {
        setupBorder()
        setupLabel()
    }
    
    private func setupBorder() {
        layer.borderColor = fillColor.CGColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    
    private func setupLabel() {
        label = UILabel()
        label.font = UIFont(name: "SF UI Display", size: 18.0)
        label.textColor = fillColor
        label.textAlignment = .Center
        
        addSubview(label)
        label.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: -
    // MARK: - Update
    
    private func updateFill() {
        if filled {
            backgroundColor = fillColor
            label.textColor = UIColor.whiteColor()
        } else {
            backgroundColor = UIColor.whiteColor()
            label.textColor = fillColor
        }
    }
    
    
}
