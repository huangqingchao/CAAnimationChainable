//
//  UIView+CAAnimationChainable.swift
//  CAAnimaChainable
//
//  Created by 黄庆超 on 2024/3/23.
//

import UIKit

public extension UIView {
    var animaChain: CAAnimationChain {
        self.layer.animaChain
    }
}
