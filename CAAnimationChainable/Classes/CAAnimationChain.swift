//
//  CAAnimationChain.swift
//  CAAnimaChainable
//
//  Created by 黄庆超 on 2024/3/23.
//

import UIKit

public class CAAnimationChain {
    // 是否执行动画中
    public var isExecAnimation = false
    
    weak private var _layer: CALayer?
    
    private var _bufferAnimations: [Animation] = []
    private var _executingAnimations: [Animation]?
    private var _executingAnimationIndex: Int?
    
    lazy private var _animationDelegateProxy: CAAnimationDelegateProxy = .init(base: self)
    
    init(layer: CALayer) {
        self._layer = layer
    }
    
    public func add(anima: CAAnimation, completion: os_block_t? = nil) -> Self {
        anima.isRemovedOnCompletion = false
        anima.fillMode = .both
        self._bufferAnimations.append(.init(animation: anima, completion: completion))
        return self
    }
    
    public func add(action: CAAnimationChain.Action,
                    duration: CFTimeInterval,
                    autoreverses: Bool = false,
                    repeatCount: Float = 1,
                    timing: CAMediaTimingFunctionName? = nil,
                    completion: os_block_t? = nil) -> Self {
        
        let animation = action.animation
        animation.delegate = self._animationDelegateProxy
        
        animation.duration = duration
        animation.autoreverses = autoreverses
        animation.repeatCount = repeatCount
        
        if let timing {
            animation.timingFunction = CAMediaTimingFunction(name: timing)
        }
        
        return self.add(anima: animation, completion: completion)
    }
    
    public func add(actions: [CAAnimationChain.Action],
                    duration: CFTimeInterval,
                    autoreverses: Bool = false,
                    repeatCount: Float = 1,
                    timing: CAMediaTimingFunctionName? = nil,
                    completion: os_block_t? = nil) -> Self {
        
        let group = CAAnimationGroup()
        group.animations = actions.map { $0.animation }
        
        group.duration = duration
        group.autoreverses = autoreverses
        group.repeatCount = repeatCount
        
        if let timing {
            group.timingFunction = CAMediaTimingFunction(name: timing)
        }
        
        return self.add(anima: group, completion: completion)
    }
    
    public func run() {
        self.cancel()
        
        guard !self._bufferAnimations.isEmpty else {
            return
        }
        
        self.isExecAnimation = true
        
        self._executingAnimations = self._bufferAnimations
        self._bufferAnimations = []
        
        self._executingAnimationIndex = 0
        let animation = self._executingAnimations![0]
        self._layer?.add(animation.animation, forKey: animation.key)
    }
    
    public func cancel() {
        self._executingAnimationIndex = nil
        self._executingAnimations?.forEach({
            self._layer?.removeAnimation(forKey: $0.key)
        })
        self._executingAnimations = nil
        
        self.isExecAnimation = false
    }
}

//MARK: - CAAnimationChain.Animation
private extension CAAnimationChain {
    class Animation {
        let key: String = UUID().uuidString
        
        let animation: CAAnimation
        let completion: os_block_t?
        
        init(animation: CAAnimation, completion: os_block_t?) {
            self.animation = animation
            self.completion = completion
        }
    }
}

//MARK: - CAAnimation Delegate
private extension CAAnimationChain {
    class CAAnimationDelegateProxy: NSObject, CAAnimationDelegate {
        weak private var _base: CAAnimationChain?
        
        init(base: CAAnimationChain) {
            self._base = base
        }
        
        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            guard let executingAnimationIndex = self._base?._executingAnimationIndex,
                  let executingAnimations = self._base?._executingAnimations else { return }
            
            executingAnimations[executingAnimationIndex].completion?()
            
            if executingAnimationIndex == executingAnimations.count - 1 {
                self._base?._executingAnimationIndex = nil
            } else {
                self._base?._executingAnimationIndex = executingAnimationIndex + 1
                let animation = executingAnimations[executingAnimationIndex + 1]
                self._base?._layer?.add(animation.animation, forKey: animation.key)
            }
        }
    }
}
