//
//  InfoBubble.swift
//  enrollment
//
//  Created by Jay Latman on 7/24/18.
//  Copyright © 2018 IBM. All rights reserved.
//
// 
//

import Cocoa

public class InfoBubble : NSObject {
    
    //// Cache
    private struct Cache {
        static var imageOfInfo_bubble: NSImage?
    }
    
    //// Drawing Methods
    @objc dynamic public class func drawInfo_bubble(frame targetFrame: NSRect = NSRect(x: 0, y: 0, width: 18, height: 18), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Resize to Target Frame
        NSGraphicsContext.saveGraphicsState()
        let resizedFrame: NSRect = resizing.apply(rect: NSRect(x: 0, y: 0, width: 18, height: 18), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 18, y: resizedFrame.height / 18)
        
        
        //// Color Declarations
        let infoButtonStroke = ColorConstants.InfoButton.stroke
        let infoButtonBackground = ColorConstants.InfoButton.background
        let infoButtonColor = ColorConstants.InfoButton.color
        //// Group 2
        //// Group 3
        //// b Drawing
        let bPath = NSBezierPath(ovalIn: NSRect(x: 1.5, y: 1.34, width: 15, height: 15))
        infoButtonStroke?.setFill()
        bPath.fill()
        NSColor.black.setStroke()
        bPath.lineWidth = 1
        bPath.lineCapStyle = .round
        bPath.stroke()
        
        //// b 2 Drawing
        let b2Path = NSBezierPath(ovalIn: NSRect(x: 1.5, y: 1.34, width: 15, height: 15))
        infoButtonBackground?.setFill()
        b2Path.fill()
        infoButtonColor?.setStroke()
        b2Path.lineWidth = 1
        b2Path.stroke()
        
        //// Group 4
        //// Bezier Drawing
        let bezierPath = NSBezierPath()
        bezierPath.move(to: NSPoint(x: 10.25, y: 10.38))
        bezierPath.line(to: NSPoint(x: 6.5, y: 10.38))
        bezierPath.line(to: NSPoint(x: 6.5, y: 9.25))
        bezierPath.line(to: NSPoint(x: 7.75, y: 9.25))
        bezierPath.line(to: NSPoint(x: 7.75, y: 5.88))
        bezierPath.line(to: NSPoint(x: 6.5, y: 5.88))
        bezierPath.line(to: NSPoint(x: 6.5, y: 4.75))
        bezierPath.line(to: NSPoint(x: 11.5, y: 4.75))
        bezierPath.line(to: NSPoint(x: 11.5, y: 5.88))
        bezierPath.line(to: NSPoint(x: 10.25, y: 5.88))
        bezierPath.line(to: NSPoint(x: 10.25, y: 10.38))
        bezierPath.close()
        bezierPath.move(to: NSPoint(x: 10.25, y: 12.62))
        bezierPath.line(to: NSPoint(x: 10.25, y: 12.62))
        bezierPath.curve(to: NSPoint(x: 9, y: 11.5), controlPoint1: NSPoint(x: 10.25, y: 12), controlPoint2: NSPoint(x: 9.69, y: 11.5))
        bezierPath.curve(to: NSPoint(x: 7.75, y: 12.62), controlPoint1: NSPoint(x: 8.31, y: 11.5), controlPoint2: NSPoint(x: 7.75, y: 12))
        bezierPath.line(to: NSPoint(x: 7.75, y: 12.62))
        bezierPath.curve(to: NSPoint(x: 9, y: 13.75), controlPoint1: NSPoint(x: 7.75, y: 13.25), controlPoint2: NSPoint(x: 8.31, y: 13.75))
        bezierPath.curve(to: NSPoint(x: 10.25, y: 12.62), controlPoint1: NSPoint(x: 9.69, y: 13.75), controlPoint2: NSPoint(x: 10.25, y: 13.25))
        bezierPath.close()
        bezierPath.windingRule = .evenOdd
        infoButtonColor?.setFill()
        bezierPath.fill()
        
        NSGraphicsContext.restoreGraphicsState()
        
    }
    
    //// Generated Images
    
    @objc dynamic public class var imageOfInfo_bubble: NSImage {
        if Cache.imageOfInfo_bubble != nil {
            return Cache.imageOfInfo_bubble!
        }
        
        Cache.imageOfInfo_bubble = NSImage(size: NSSize(width: 18, height: 18), flipped: false) { _ in
            InfoBubble.drawInfo_bubble()
            
            return true
        }
        
        return Cache.imageOfInfo_bubble!
    }
    
    
    
    
    @objc(InfoBubbleResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: NSRect, target: NSRect) -> NSRect {
            if rect == target || target == NSRect.zero {
                return rect
            }
            
            var scales = NSSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
