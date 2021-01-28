//
//  LoaderView.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/16/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class LoaderView: NSView {
    
    enum State {
        case inQueue
        case failure
        case success
        case inProgress
        case partial
        
        var image: NSImage? {
            switch self {
            case .failure:
                return NSImage(named: "failure")
            case .inProgress:
                return NSImage(named: "inProgress")
            case .success:
                return NSImage(named: "success")
            case .inQueue:
                return NSImage(named: "inQueue")
            case .partial:
                return NSImage(named: "partial")
            }
        }
        
        var isAnimationNeeded: Bool {
            return self == .inProgress
        }
    }
    
    var imageView: RotableImageView!
    var state: State {
        didSet {
            guard imageView != nil else { return }
            updateView()
        }
    }
    var animation: CABasicAnimation {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = Float(Double.pi * 2.0)
        rotation.duration = 5
        rotation.repeatCount = Float.infinity
        return rotation
    }
    
    override init(frame frameRect: NSRect) {
        state = .inQueue
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        state = .inQueue
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        imageView = RotableImageView(image: state.image ?? NSImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.wantsLayer = true
        self.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.imageView.image = self.state.image
            guard self.state.isAnimationNeeded else {
                self.stopAnimation()
                return
            }
            self.startAnimation()
        }
    }
    
    private func startAnimation() {
        imageView.rotate()
    }
    
    private func stopAnimation() {
        imageView.stopRotation()
    }
}
