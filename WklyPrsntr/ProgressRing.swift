//
//  ProgressRingView.swift
//  KuBi
//
//  Created by Philipp Seibel on 12.09.17.
//  Copyright © 2017 DB Systel GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressRingView: UIView {
    
    @IBInspectable
    var backgroundRingColor: UIColor = .lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var foregroundColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var ringWidth: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var progress: CGFloat = 0.81 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var radius: CGFloat {
        return (min(bounds.width, bounds.height)/2.0)-(ringWidth/2.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let offset: CGFloat = .pi / 2.0
        
        context.setLineWidth( ringWidth)
        
        context.saveGState()
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: (.pi * 2), clockwise: true)
        context.setStrokeColor(backgroundRingColor.cgColor)
        context.strokePath()
        context.restoreGState()
        
        context.setLineCap(.round)
        context.addArc(center: center, radius: radius, startAngle: 0-offset, endAngle: ((.pi * 2) * progress)-offset, clockwise: false)
        context.setStrokeColor(foregroundColor.cgColor)
        context.strokePath()
    }
    
}

