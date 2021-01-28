//
//  Indicators.swift
//  enrollment
//
//  Created by Jay Latman on 9/2/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class Indicators: NSView {

    @objc dynamic public class func drawSuccess(frame: NSRect = NSRect(x: 1, y: 1, width: 20, height: 20)) {
        //// Oval Drawing
        let ovalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 2, y: frame.minY + frame.height - 18, width: 16, height: 16))
        
        ColorConstants.Indicators.Success.ovalFill?.setFill()
        ColorConstants.Indicators.Success.ovalStroke?.setStroke()
        
        ovalPath.fill()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        //// Bezier Drawing
        let bezierPath = NSBezierPath()
        bezierPath.move(to: NSPoint(x: frame.minX + 15, y: frame.maxY - 7.12))
        bezierPath.line(to: NSPoint(x: frame.minX + 13.95, y: frame.maxY - 6))
        bezierPath.line(to: NSPoint(x: frame.minX + 8.51, y: frame.maxY - 11.77))
        bezierPath.line(to: NSPoint(x: frame.minX + 6.05, y: frame.maxY - 9.16))
        bezierPath.line(to: NSPoint(x: frame.minX + 5, y: frame.maxY - 10.28))
        bezierPath.line(to: NSPoint(x: frame.minX + 8.51, y: frame.maxY - 14))
        bezierPath.line(to: NSPoint(x: frame.minX + 15, y: frame.maxY - 7.12))
        bezierPath.close()
        
        ColorConstants.Indicators.Success.checkFill?.setFill()
        ColorConstants.Indicators.Success.checkStroke?.setStroke()
        
        bezierPath.fill()
        bezierPath.lineWidth = 0.5
        bezierPath.miterLimit = 4
        bezierPath.stroke()
    }
    
    @objc dynamic public class func drawFailure(frame: NSRect = NSRect(x: 1, y: 1, width: 20, height: 20)) {
        //// Bezier Drawing
        let bezier2Path = NSBezierPath()
        bezier2Path.move(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 1))
        bezier2Path.line(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 1))
        bezier2Path.curve(to: NSPoint(x: frame.minX + 1, y: frame.maxY - 10), controlPoint1: NSPoint(x: frame.minX + 5.03, y: frame.maxY - 1), controlPoint2: NSPoint(x: frame.minX + 1, y: frame.maxY - 5.03))
        bezier2Path.curve(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 19), controlPoint1: NSPoint(x: frame.minX + 1, y: frame.maxY - 14.97), controlPoint2: NSPoint(x: frame.minX + 5.03, y: frame.maxY - 19))
        bezier2Path.line(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 19))
        bezier2Path.curve(to: NSPoint(x: frame.minX + 19, y: frame.maxY - 10), controlPoint1: NSPoint(x: frame.minX + 14.97, y: frame.maxY - 19), controlPoint2: NSPoint(x: frame.minX + 19, y: frame.maxY - 14.97))
        bezier2Path.curve(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 1), controlPoint1: NSPoint(x: frame.minX + 19, y: frame.maxY - 5.03), controlPoint2: NSPoint(x: frame.minX + 14.97, y: frame.maxY - 1))
        bezier2Path.close()
        bezier2Path.move(to: NSPoint(x: frame.minX + 13.98, y: frame.maxY - 12.39))
        bezier2Path.line(to: NSPoint(x: frame.minX + 12.39, y: frame.maxY - 13.98))
        bezier2Path.line(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 11.59))
        bezier2Path.line(to: NSPoint(x: frame.minX + 7.61, y: frame.maxY - 13.98))
        bezier2Path.line(to: NSPoint(x: frame.minX + 6.02, y: frame.maxY - 12.39))
        bezier2Path.line(to: NSPoint(x: frame.minX + 8.41, y: frame.maxY - 10))
        bezier2Path.line(to: NSPoint(x: frame.minX + 6.02, y: frame.maxY - 7.61))
        bezier2Path.line(to: NSPoint(x: frame.minX + 7.61, y: frame.maxY - 6.02))
        bezier2Path.line(to: NSPoint(x: frame.minX + 10, y: frame.maxY - 8.41))
        bezier2Path.line(to: NSPoint(x: frame.minX + 12.39, y: frame.maxY - 6.02))
        bezier2Path.line(to: NSPoint(x: frame.minX + 13.98, y: frame.maxY - 7.61))
        bezier2Path.line(to: NSPoint(x: frame.minX + 11.59, y: frame.maxY - 10))
        bezier2Path.line(to: NSPoint(x: frame.minX + 13.98, y: frame.maxY - 12.39))
        bezier2Path.close()
        bezier2Path.windingRule = .evenOdd
        
        ColorConstants.Indicators.Failure.fill?.setFill()
        
        bezier2Path.fill()
    }
    
    @objc dynamic public class func drawPartial(frame: NSRect = NSRect(x: 1, y: 1, width: 20, height: 20)) {
        //// Oval Drawing
        let oval2Path = NSBezierPath(ovalIn: NSRect(x: frame.minX + 1, y: frame.minY + frame.height - 19, width: 18, height: 18))
        
        ColorConstants.Indicators.Partial.fill?.setFill()
       
        oval2Path.fill()
        
        //// Rectangle Drawing
        let rectanglePath = NSBezierPath(rect: NSRect(x: frame.minX + 5, y: frame.minY + frame.height - 11, width: 10, height: 2))
        
        ColorConstants.Indicators.Partial.dashFill?.setFill()
        
        rectanglePath.fill()
    }
    
    @objc dynamic public class func drawQueued(frame: NSRect = NSRect(x: 1, y: 1, width: 20, height: 20)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Oval Drawing
        NSGraphicsContext.saveGraphicsState()
        context.setAlpha(1.0)
        
        let ovalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 2, y: frame.minY + frame.height - 18, width: 16, height: 16))
        
        ColorConstants.Indicators.Queued.ovalStroke?.setStroke()
        
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    @objc dynamic public class func drawActive(frame: NSRect = NSRect(x: 1, y: 1, width: 20, height: 20)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Oval Drawing
        NSGraphicsContext.saveGraphicsState()
        context.setAlpha(1.0)
        
        let ovalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 2, y: frame.minY + frame.height - 18, width: 16, height: 16))
        
        ColorConstants.Indicators.Active.ovalStroke?.setStroke()
        
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    @objc dynamic public class func drawActiveOpen(frame: NSRect = NSRect(x: 1, y: 1, width: 20, height: 20), master: CGFloat = 1) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Variable Declarations
        let rotation: CGFloat = master * -719
        
        //// Oval Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 0.5 * frame.width, y: frame.minY + 0.5 * frame.height)
        context.rotate(by: rotation * CGFloat.pi/180)
        
        let ovalRect = NSRect(x: -8, y: -8, width: 16, height: 16)
        let ovalPath = NSBezierPath()
        ovalPath.appendArc(withCenter: NSPoint(x: 0.0, y: 0.0), radius: ovalRect.width / 2, startAngle: 376, endAngle: 63, clockwise: true)
        
        var ovalTransform = AffineTransform()
        ovalTransform.translate(x: ovalRect.midX, y: ovalRect.midY)
        ovalTransform.scale(x: 1, y: ovalRect.height / ovalRect.width)
        ovalPath.transform(using: ovalTransform)
        
        ColorConstants.Indicators.Active.ovalStroke?.setStroke()
        
        ovalPath.lineWidth = 2
        ovalPath.lineCapStyle = .round
        ovalPath.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    //// Generated Images
    
    @objc dynamic public class func imageSuccess(imageSize: NSSize = NSSize(width: 20, height: 20)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawSuccess(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageFailure(imageSize: NSSize = NSSize(width: 20, height: 20)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawFailure(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imagePartial(imageSize: NSSize = NSSize(width: 20, height: 20)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawPartial(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageQueued(imageSize: NSSize = NSSize(width: 20, height: 20)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawQueued(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageActive(imageSize: NSSize = NSSize(width: 20, height: 20)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawActive(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageActiveOpen(imageSize: NSSize = NSSize(width: 20, height: 20)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawActiveOpen(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageSuccessSmall(imageSize: NSSize = NSSize(width: 10, height: 10)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawSuccess(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageFailureSmall(imageSize: NSSize = NSSize(width: 10, height: 10)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawFailure(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageProgressSmall(imageSize: NSSize = NSSize(width: 10, height: 10)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawQueued(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageActiveSmall(imageSize: NSSize = NSSize(width: 10, height: 10)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawActive(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
    
    @objc dynamic public class func imageActiveOpenSmall(imageSize: NSSize = NSSize(width: 10, height: 10)) -> NSImage {
        return NSImage(size: imageSize, flipped: false) {_ in
            Indicators.drawActiveOpen(frame: NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            return true
        }
    }
}

struct IndicatorSize {
    static let bundleInstall = NSSize(width: 20.0, height: 20.0)
    static let appInstall = NSSize(width: 25.0, height: 25.0)
}
