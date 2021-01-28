//
//  RotableView.swift
//  enrollment
//
//  Created by Simone Martorelli on 9/2/20.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import AppKit

class RotableView: NSView {
    private let kRotationAnimationKey = "rotationanimationkey"
    private var isAnchorPointDetermined: Bool = false
    
    func determineAnchorPoint() {
        guard !isAnchorPointDetermined else { return }
        self.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        guard let frame = self.layer?.frame else { return }
        let xCoord = Float(frame.origin.x + frame.size.width)
        let yCoord = Float(frame.origin.y + frame.size.height)
        let myPoint = CGPoint(x: CGFloat(xCoord), y: CGFloat(yCoord))
        self.layer?.position = myPoint
        isAnchorPointDetermined = true
    }
    
    func rotate(duration: Double = 1.0) {
        determineAnchorPoint()
        if layer?.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * -2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer?.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }

    func stopRotation() {
        if layer?.animation(forKey: kRotationAnimationKey) != nil {
            layer?.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
}
