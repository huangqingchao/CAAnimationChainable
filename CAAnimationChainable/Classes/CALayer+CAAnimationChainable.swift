//
//  CALayer+CAAnimationChainable.swift
//  CAAnimaChainable
//
//  Created by 黄庆超 on 2024/3/23.
//

import UIKit

public extension CALayer {
    
    static private var animationChainKey = 0
    
    var animaChain: CAAnimationChain {
        get {
            guard let chain = objc_getAssociatedObject(self, &CALayer.animationChainKey) as? CAAnimationChain else {
                let chain = CAAnimationChain(layer: self)
                self.animaChain = chain
                return chain
            }
            return chain
        }
        set {
            objc_setAssociatedObject(self, &CALayer.animationChainKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
