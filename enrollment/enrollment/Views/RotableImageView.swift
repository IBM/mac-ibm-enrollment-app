//
//  RotableImageView.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/22/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import AppKit

class RotableImageView: NSImageView {
    private let kRotationAnimationKey = "rotationanimationkey"
    
    /// This method locate the anchor point of the image view to allow for proper rotation.
    func determineAnchorPoint() {
        guard self.layer?.anchorPoint != CGPoint(x: 0.5, y: 0.5) else { return }
        self.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        guard let frame = self.layer?.frame else { return }
        let xCoord = Float(frame.origin.x + frame.size.width)
        let yCoord = Float(frame.origin.y + frame.size.height)
        let myPoint = CGPoint(x: CGFloat(xCoord), y: CGFloat(yCoord))
        self.layer?.position = myPoint
    }

    /// This method start the rotation of the imageView.
    /// - Parameter duration: double value representing the seconds of rotation.
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
    
    /// This method stop the rotation animation.
    func stopRotation() {
        if layer?.animation(forKey: kRotationAnimationKey) != nil {
            layer?.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
}
