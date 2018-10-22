//
//  CircularStatus.swift
//  enrollment
//
//  Created by Jay Latman on 9/2/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class CircularStatus: NSView, CAAnimationDelegate {
    
    private static let rotationAnimatonKey = "rotation"
    
    private let imageLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    var state = StatusState.inQueue {
        didSet {
            guard oldValue != state else {
                return
            }
            
            let borderWidthAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.lineWidth))
            borderWidthAnimation.fromValue = self.imageLayer.lineWidth
            borderWidthAnimation.toValue = self.state.borderWidth
            
            self.imageLayer.add(borderWidthAnimation, forKey: nil)
            
            let contentAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.contents))
            contentAnimation.fromValue = self.imageLayer.contents
            contentAnimation.toValue = self.state.image
            
            self.imageLayer.add(contentAnimation, forKey: nil)
            
            self.imageLayer.lineWidth = self.state.borderWidth
            
            self.imageLayer.contents = state.image
        }
    }
    
    
    override var intrinsicContentSize: NSSize {
        get {
            guard let imageSize = StatusState.success.image else {
                return NSSize.zero
            }
            return NSSize(width: imageSize.size.width + 4, height: imageSize.size.height + 4)
        }
    }
    
    convenience init() {
        self.init(frame: NSRect.zero)
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    private func configure() {
        self.layer = CALayer()
        self.layer?.contentsGravity = CALayerContentsGravity.resizeAspectFill
        imageLayer.contents = self.state.image
        imageLayer.strokeColor = ColorConstants.Indicators.Active.ovalStroke?.cgColor
        imageLayer.fillColor = NSColor.clear.cgColor
        imageLayer.lineWidth = self.state.borderWidth
        
        layer?.addSublayer(imageLayer)
    }
    
    override func layout() {
        super.layout()
        
        let imageSize = StatusState.success.image?.size ?? NSSize.zero
        var imageLayerFrame = CGRect(origin: CGPoint.zero, size: imageSize)
        
        imageLayerFrame.origin.x = self.bounds.midX - imageLayerFrame.midX
        imageLayerFrame.origin.y = self.bounds.midY - imageLayerFrame.midY
        
        self.imageLayer.frame = imageLayerFrame
        self.imageLayer.path = CGPath(ellipseIn: self.imageLayer.bounds, transform: nil)
        
        self.progressLayer.frame = imageLayerFrame
        self.progressLayer.path = CGPath(ellipseIn: self.imageLayer.bounds, transform: nil)
    }
}

private extension StatusState {
    var image: NSImage? {
        get {
            switch self {
            case .appInQueue: return Indicators.imageQueued(imageSize: IndicatorSize.appInstall)
            case .appInProgress: return Indicators.imageActive(imageSize: IndicatorSize.appInstall)
            case .appSuccess: return Indicators.imageSuccess(imageSize: IndicatorSize.appInstall)
            case .appFailure: return Indicators.imageFailure(imageSize: IndicatorSize.appInstall)
            case .appInProgressAnimated: return Indicators.imageActiveOpen(imageSize: IndicatorSize.appInstall)
            case .inProgress: return Indicators.imageActive(imageSize: IndicatorSize.bundleInstall)
            case .success: return Indicators.imageSuccess(imageSize: IndicatorSize.bundleInstall)
            case .failure: return Indicators.imageFailure(imageSize: IndicatorSize.bundleInstall)
            case .partial: return Indicators.imagePartial(imageSize: IndicatorSize.bundleInstall)
            case .inQueue: return Indicators.imageQueued(imageSize: IndicatorSize.bundleInstall)
            case .inProgressAnimated: return Indicators.imageActiveOpen(imageSize: IndicatorSize.bundleInstall)
            }
        }
    }
    
    var borderWidth: CGFloat {
        get {
            switch self {
            case .inProgress, .success, .failure, .partial, .inQueue, .inProgressAnimated, .appInProgress, .appInQueue, .appSuccess, .appFailure, .appInProgressAnimated: return 0.0
            }
        }
    }
}
