//
//  AnimatorFactory.swift
//  KuBi
//
//  Created by Malte Bünz on 08.12.17.
//  Copyright © 2017 DB Systel GmbH. All rights reserved.
//

import Foundation
import UIKit

public struct Animation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

extension CALayer {
    var hasShadow: Bool {
        return shadowRadius > 0.0 ? true : false
    }
}

public extension Animation {
    
    static let animationDuration: TimeInterval = 0.3
    
    static func scaleDown(duration: TimeInterval = Animation.animationDuration, factor: CGFloat = 0.92) -> Animation {
        return Animation(duration: duration, closure: {
            $0.transform = CGAffineTransform(scaleX: factor, y: factor)
            if $0.layer.hasShadow {
                $0.layer.shadowRadius = 15.0
            }
        })
    }
    
    static func scaleUp(duration: TimeInterval = Animation.animationDuration) -> Animation {
        return Animation(duration: duration, closure: {
            $0.transform = .identity
            if $0.layer.hasShadow {
                $0.layer.shadowRadius = 5.0
            }
        })
    }
}

class AnimatorFactory {
    
    static func scaleDownAnimator(duration: TimeInterval = Animation.animationDuration, factor: CGFloat = 0.93, view: UIView) -> UIViewPropertyAnimator {
        let easingDuration = TimeInterval(factor) * duration / TimeInterval(factor)
        let scalingDuration = duration - easingDuration
        let animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: scalingDuration,
                                                                      delay: 0.0,
                                                                      options: .curveEaseInOut,
                                                                      animations: {
                                                                        Animation.scaleDown(duration: 0.3).closure(view)
        })
        return animator
    }
    
    static func scaleUpAnimator(duration: TimeInterval = Animation.animationDuration, factor: CGFloat = 1.0, view: UIView) -> UIViewPropertyAnimator {
        let easingDuration = TimeInterval(factor) * duration / TimeInterval(factor)
        let scalingDuration = duration - easingDuration
        let animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: scalingDuration,
                                                                      delay: 0.0,
                                                                      options: .curveEaseInOut,
                                                                      animations: {
                                                                        Animation.scaleUp(duration: 0.2).closure(view)
        })
        return animator
    }
    
}

