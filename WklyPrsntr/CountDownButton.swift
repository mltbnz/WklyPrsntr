//
//  CountDownButton.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 09.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import UIKit

class CountDownButton: ScalableButton {

    enum ButtonState {
        case start
        case stop
        
        var text: String {
            switch self {
            case .start:
                return "Start"
            case .stop:
                return "Stop"
            }
        }
        
        var opposite: ButtonState {
            switch self {
            case .start:
                return .stop
            case .stop:
                return .start
            }
        }
    }
    
    var buttonState: ButtonState = .start {
        didSet {
            setTitle(buttonState.text, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleButton()
        setTitle(buttonState.text, for: .normal)
    }
    
    fileprivate func styleButton() {
        self.layer.cornerRadius = 50.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 5.0
        self.titleLabel?.textColor = .white
    }

}

class ScalableButton: UIButton {
    
    var animator: UIViewPropertyAnimator? {
        didSet {
            animator?.startAnimation()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        self.addTarget(self, action: #selector(ScalableButton.touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(ScalableButton.touchUp), for: .touchUpInside)
    }
    
    fileprivate func configure() {
        adjustsImageWhenHighlighted = false
    }
    
    @objc func touchDown() {
        animator = AnimatorFactory.scaleDownAnimator(view: self)
    }
    
    @objc func touchUp() {
        animator = AnimatorFactory.scaleUpAnimator(view: self)
    }
}
