//
//  CAAnimationChainAction+Extension.swift
//  HiNen
//
//  Created by 黄庆超 on 2024/3/23.
//

import UIKit

extension CAAnimation {
    static func swing(amplitude: CGFloat = 8, duration: CFTimeInterval = 0.1, repeatCount: Float = 2) -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.values = [0, -amplitude, amplitude, 0]
        animation.duration = duration
        animation.repeatCount = repeatCount
        return animation
    }
}
