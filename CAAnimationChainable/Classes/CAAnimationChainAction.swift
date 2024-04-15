//
//  CAAnimationChainAction.swift
//  HiNen
//
//  Created by 黄庆超 on 2024/3/23.
//

import UIKit

//MARK: - CAAnimationChain.Action
public extension CAAnimationChain {
    enum Action {
        case translation(_ v: CGVector, from: CGVector? = nil)
        case translationX(_ x: CGFloat, from: CGFloat? = nil)
        case translationY(_ y: CGFloat, from: CGFloat? = nil)
        case scale(_ s: CGFloat, from: CGFloat? = nil)
        case scaleX(_ x: CGFloat, from: CGFloat? = nil)
        case scaleY(_ y: CGFloat, from: CGFloat? = nil)
        case scaleZ(_ z: CGFloat, from: CGFloat? = nil)
        case backgroundColor(_ color: UIColor, from: UIColor? = nil)
    }
}

extension CAAnimationChain.Action {
    internal var animation: CAAnimation {
        let animation: CABasicAnimation
        switch self {
        case let .translation(v, from):
            animation = CABasicAnimation(keyPath: "transform.translation")
            animation.toValue = v
            if let from { animation.fromValue = from }
        case let .translationX(x, from):
            animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.toValue = x
            if let from { animation.fromValue = from }
        case let .translationY(y, from):
            animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.toValue = y
            if let from { animation.fromValue = from }
        case let .scale(s, from):
            animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = s
            if let from { animation.fromValue = from }
        case let .scaleX(x, from):
            animation = CABasicAnimation(keyPath: "transform.scale.x")
            animation.toValue = x
            if let from { animation.fromValue = from }
        case let .scaleY(y, from):
            animation = CABasicAnimation(keyPath: "transform.scale.y")
            animation.toValue = y
            if let from { animation.fromValue = from }
        case let .scaleZ(z, from):
            animation = CABasicAnimation(keyPath: "transform.scale.z")
            animation.toValue = z
            if let from { animation.fromValue = from }
        case let .backgroundColor(color, from):
            animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.toValue = color
            if let from { animation.fromValue = from }
        }
        return animation
    }
}
