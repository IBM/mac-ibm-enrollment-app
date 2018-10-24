//
//  AnimatedGIFImageView.swift
//  enrollment
//
//  Created by Jay Latman on 8/1/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class AnimatedGIFImageView: NSView {
    
    static let imageFrameAnimationKey = "AnimatedGIFImageView_ImageFrameAnimationKey"
    
    var animationLayer: CALayer = CALayer()
    
    var image: NSImage? {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    var imageData: Data? {
        didSet {
            self.animationLayer.removeAnimation(forKey: AnimatedGIFImageView.imageFrameAnimationKey)
            
            guard let imageData = self.imageData else {
                self.image = nil
                return
            }
            
            guard
                let image = NSImage(data: imageData),
                let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil),
                let containerType = CGImageSourceGetType(imageSource), UTTypeConformsTo(containerType, kUTTypeGIF)
                else
            {
                NSLog("ERROR: \(#file):\(#file)): Image data is not a valid GIF file.")
                return
            }
            
            self.image = image
            let defaultGIFFrameDelay = 0.1 as TimeInterval
            var lastFrameDelay = 0.0
            
            for imageRepresentation in image.representations {
                guard
                    let bitmapRepresentation = imageRepresentation as? NSBitmapImageRep,
                    let frameCount = bitmapRepresentation.value(forProperty: NSBitmapImageRep.PropertyKey.frameCount) as? Int
                    else { continue }
                
                var imageFrames = [CGImage]()
                var totalDuration = 0.0 as TimeInterval
                for frameCounter in 0 ..< frameCount {
                    bitmapRepresentation.setProperty(NSBitmapImageRep.PropertyKey.currentFrame, withValue: frameCounter)
                    
                    guard let frameImage = bitmapRepresentation.cgImage else {
                        NSLog("ERROR: \(#file):\(#file)): Count not access frame number \(frameCounter)")
                        continue
                    }
                    
                    imageFrames.append(frameImage)
                    
                    let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, frameCounter, nil) as NSDictionary?
                    let animationProperties = properties?.object(forKey: kCGImagePropertyGIFDictionary) as? NSDictionary
                    var frameDelay = animationProperties?.object(forKey: kCGImagePropertyGIFDelayTime) as? TimeInterval
                    if frameDelay == nil {
                        frameDelay = lastFrameDelay
                    }
                    totalDuration += frameDelay!
                    lastFrameDelay = (frameDelay! == 0.0) ? defaultGIFFrameDelay : frameDelay!
                }
                
                let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.contents))
                animation.values = imageFrames
                animation.duration = totalDuration
                animation.repeatCount = Float.infinity
                self.animationLayer.add(animation, forKey: AnimatedGIFImageView.imageFrameAnimationKey)
                
                break
            }
        }
    }
    
    override var intrinsicContentSize: NSSize {
        get {
            return self.image?.size ?? NSSize.zero
        }
    }
    
    override var frame: NSRect {
        didSet {
            self.animationLayer.frame = self.bounds
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.commonInt()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.commonInt()
    }
    
    func commonInt() {
        self.wantsLayer = true
        self.layer?.addSublayer(self.animationLayer)
    }
    
}


