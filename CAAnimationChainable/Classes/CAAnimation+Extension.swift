//
//  CAAnimationChainAction+Extension.swift
//  HiNen
//
//  Created by 黄庆超 on 2024/3/23.
//

import UIKit

public extension CAAnimation {
    
    /// 左右摇晃
    static func swing(amplitude: CGFloat = 8, duration: CFTimeInterval = 0.1, repeatCount: Float = 2) -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.values = [0, -amplitude, amplitude, 0]
        animation.duration = duration
        animation.repeatCount = repeatCount
        return animation
    }
    
    /// 旋转
    static func rotate(angle: Float,
                       duration: CFTimeInterval = 1,
                       repeatCount: Float = 1,
                       autoreverses: Bool = false,
                       clockwise: Bool = true) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = clockwise ? angle : -angle
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = autoreverses
        return animation
    }
}
