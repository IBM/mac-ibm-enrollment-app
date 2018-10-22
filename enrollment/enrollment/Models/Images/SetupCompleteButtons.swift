//
//  SetupCompleteButtons.swift
//  enrollment
//
//  Created by Jay Latman on 8/13/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

public class SetupCompleteButtons: NSObject {
    
    //// Cache
    private struct Cache {
        static var imageOfMigrationButton: NSImage?
        static var imageOfURLButton: NSImage?
        static var imageOfSelfServiceButton: NSImage?
        static var imageOfBackupButton: NSImage?
        static var imageOfQnAButton: NSImage?
    }
    
    //// Drawing Methods
    
    @objc dynamic public class func drawMigration(frame: NSRect = NSRect(x: 0, y: 0, width: 85, height: 81)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Color Declarations
        let screenBezelColor = ColorConstants.SetupComplete.MigrationButton.screenBezel
        let screenBackgroundColor = ColorConstants.SetupComplete.MigrationButton.laptopScreenBackground
        let arrowColor = ColorConstants.SetupComplete.MigrationButton.arrow_and_Keyboard
        let innerRingColor = ColorConstants.SetupComplete.MigrationButton.innerRing
        
        //// outer_ring Drawing
        let outer_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 4, y: frame.minY + frame.height - 79, width: 77, height: 77))
        ColorConstants.SetupComplete.outerRing.setStroke()
        outer_button_ringPath.lineWidth = 1.5
        outer_button_ringPath.lineCapStyle = .round
        outer_button_ringPath.lineJoinStyle = .round
        outer_button_ringPath.stroke()
        
        //// inner_button_ring Drawing
        let inner_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 5, y: frame.minY + frame.height - 78, width: 75, height: 75))
        NSColor.white.setFill()
        inner_button_ringPath.fill()
        innerRingColor?.setStroke()
        inner_button_ringPath.lineWidth = 1.5
        inner_button_ringPath.lineCapStyle = .round
        inner_button_ringPath.lineJoinStyle = .round
        inner_button_ringPath.stroke()
        
        //// Screen Drawing
        let screenPath = NSBezierPath(roundedRect: NSRect(x: frame.minX + 28, y: frame.minY + frame.height - 53, width: 40, height: 29), xRadius: 8, yRadius: 8)
        screenBackgroundColor?.setFill()
        screenPath.fill()
        screenBezelColor?.setStroke()
        screenPath.lineWidth = 4
        screenPath.stroke()
        
        //// Keyboard Drawing
        let keyboardPath = NSBezierPath(roundedRect: NSRect(x: frame.minX + 25.5, y: frame.minY + frame.height - 59.5, width: 45, height: 3), xRadius: 1.5, yRadius: 1.5)
        arrowColor?.setFill()
        keyboardPath.fill()
        screenBezelColor?.setStroke()
        keyboardPath.lineWidth = 1
        keyboardPath.stroke()
        
        //// Arrow Drawing
        let arrowPath = NSBezierPath()
        arrowPath.move(to: NSPoint(x: frame.minX + 23.13, y: frame.maxY - 40.67))
        arrowPath.line(to: NSPoint(x: frame.minX + 15.16, y: frame.maxY - 35.83))
        arrowPath.line(to: NSPoint(x: frame.minX + 15.16, y: frame.maxY - 45.51))
        arrowPath.line(to: NSPoint(x: frame.minX + 23.13, y: frame.maxY - 40.67))
        arrowPath.close()
        arrowPath.move(to: NSPoint(x: frame.minX + 4.75, y: frame.maxY - 41.3))
        arrowPath.line(to: NSPoint(x: frame.minX + 15.66, y: frame.maxY - 41.3))
        arrowPath.curve(to: NSPoint(x: frame.minX + 16.16, y: frame.maxY - 40.67), controlPoint1: NSPoint(x: frame.minX + 15.93, y: frame.maxY - 41.3), controlPoint2: NSPoint(x: frame.minX + 16.16, y: frame.maxY - 41.02))
        arrowPath.curve(to: NSPoint(x: frame.minX + 15.66, y: frame.maxY - 40.04), controlPoint1: NSPoint(x: frame.minX + 16.16, y: frame.maxY - 40.32), controlPoint2: NSPoint(x: frame.minX + 15.93, y: frame.maxY - 40.04))
        arrowPath.line(to: NSPoint(x: frame.minX + 4.75, y: frame.maxY - 40.04))
        arrowPath.curve(to: NSPoint(x: frame.minX + 4.25, y: frame.maxY - 40.67), controlPoint1: NSPoint(x: frame.minX + 4.47, y: frame.maxY - 40.04), controlPoint2: NSPoint(x: frame.minX + 4.25, y: frame.maxY - 40.32))
        arrowPath.curve(to: NSPoint(x: frame.minX + 4.75, y: frame.maxY - 41.3), controlPoint1: NSPoint(x: frame.minX + 4.25, y: frame.maxY - 41.02), controlPoint2: NSPoint(x: frame.minX + 4.47, y: frame.maxY - 41.3))
        arrowPath.close()
        arrowColor?.setFill()
        arrowPath.fill()
        
        //// AppleLogo Drawing
        let appleLogoRect = NSRect(x: frame.minX + 38, y: frame.minY + frame.height - 48, width: 19, height: 19)
        NSGraphicsContext.saveGraphicsState()
        appleLogoRect.clip()
        context.translateBy(x: appleLogoRect.minX, y: appleLogoRect.minY)
        
        SetupCompleteButtons.drawAppleLogo(frame: CGRect(origin: .zero, size: appleLogoRect.size), resizing: .stretch)
        NSGraphicsContext.restoreGraphicsState()
        
        
    }

    
    @objc dynamic public class func drawHelp(frame: NSRect = NSRect(x: 0, y: 0, width: 85, height: 81)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Color Declarations
        let windowStrokeColor = ColorConstants.SetupComplete.WebURLButton.windowStroke
        let windowBackgroundColor = ColorConstants.SetupComplete.WebURLButton.windowBackground
        let closeColor = ColorConstants.SetupComplete.WebURLButton.closeButton
        let minimizeColor = ColorConstants.SetupComplete.WebURLButton.minimizeButton
        let maximizeColor = ColorConstants.SetupComplete.WebURLButton.maximizeButton
        let innerRingColor = ColorConstants.SetupComplete.WebURLButton.innerRing
        
        //// outer_ring Drawing
        let outer_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 4, y: frame.minY + frame.height - 79, width: 77, height: 77))
        ColorConstants.SetupComplete.outerRing.setStroke()
        outer_button_ringPath.lineWidth = 1.5
        outer_button_ringPath.lineCapStyle = .round
        outer_button_ringPath.lineJoinStyle = .round
        outer_button_ringPath.stroke()
        
        
        //// inner_button_ring Drawing
        let inner_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 5, y: frame.minY + frame.height - 78, width: 75, height: 75))
        NSColor.white.setFill()
        inner_button_ringPath.fill()
        innerRingColor?.setStroke()
        inner_button_ringPath.lineWidth = 1.5
        inner_button_ringPath.lineCapStyle = .round
        inner_button_ringPath.lineJoinStyle = .round
        inner_button_ringPath.stroke()
        
        //// App Screen Window Drawing
        let rectanglePath = NSBezierPath(roundedRect: NSRect(x: frame.minX + 16, y: frame.minY + frame.height - 59, width: 55, height: 38), xRadius: 8, yRadius: 8)
        windowBackgroundColor?.setFill()
        rectanglePath.fill()
        windowStrokeColor?.setStroke()
        rectanglePath.lineWidth = 4
        rectanglePath.stroke()
        
        //// Close Control Oval Drawing
        let closeOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 20.75, y: frame.minY + frame.height - 28.75, width: 4.25, height: 4.25))
        closeColor?.setFill()
        closeOvalPath.fill()
        windowStrokeColor?.setStroke()
        closeOvalPath.lineWidth = 0.5
        closeOvalPath.stroke()
        
        //// Minimize Oval Drawing
        let minimizeOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 26.25, y: frame.minY + frame.height - 28.75, width: 4.25, height: 4.25))
        minimizeColor?.setFill()
        minimizeOvalPath.fill()
        windowStrokeColor?.setStroke()
        minimizeOvalPath.lineWidth = 0.5
        minimizeOvalPath.stroke()
        
        //// Maximize Oval Drawing
        let maximizeOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 31.75, y: frame.minY + frame.height - 28.75, width: 4.25, height: 4.25))
        maximizeColor?.setFill()
        maximizeOvalPath.fill()
        windowStrokeColor?.setStroke()
        maximizeOvalPath.lineWidth = 0.5
        maximizeOvalPath.stroke()
        
        //// Webaddress Text Drawing
        let webaddressRect = NSRect(x: frame.minX + 25, y: frame.minY + frame.height - 47, width: 37, height: 11)
        NSGraphicsContext.saveGraphicsState()
        webaddressRect.clip()
        context.translateBy(x: webaddressRect.minX, y: webaddressRect.minY)
        
        SetupCompleteButtons.drawWebURL(frame: CGRect(origin: .zero, size: webaddressRect.size), resizing: .stretch)
        NSGraphicsContext.restoreGraphicsState()
        
        
    }
    
    @objc dynamic public class func drawBackup(frame: NSRect = NSRect(x: 0, y: 0, width: 85, height: 81)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Color Declarations
        let arrowTailColor = ColorConstants.SetupComplete.BackupButton.arrowTail
        let clockhandsArrowheadColor = ColorConstants.SetupComplete.BackupButton.clockhands_and_Arrowhead
        let innerRingColor = ColorConstants.SetupComplete.BackupButton.innerRing
        
        //// outer_button_ringPath Drawing
        let outer_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 4, y: frame.minY + frame.height - 79, width: 77, height: 77))
        ColorConstants.SetupComplete.outerRing.setStroke()
        outer_button_ringPath.lineWidth = 1.5
        outer_button_ringPath.lineCapStyle = .round
        outer_button_ringPath.lineJoinStyle = .round
        outer_button_ringPath.stroke()
        
        
        //// inner_button_ring Drawing
        let inner_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 5, y: frame.minY + frame.height - 78, width: 75, height: 75))
        NSColor.white.setFill()
        inner_button_ringPath.fill()
        innerRingColor?.setStroke()
        inner_button_ringPath.lineWidth = 1.5
        inner_button_ringPath.lineCapStyle = .round
        inner_button_ringPath.lineJoinStyle = .round
        inner_button_ringPath.stroke()
        
        //// Group
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 34.29, y: frame.maxY - 33.75)
        context.rotate(by: 38.09 * CGFloat.pi/180)
        
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        //// Arrow Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 2.89, y: -11.25)
        context.rotate(by: -519.72 * CGFloat.pi/180)
        
        let ovalRect = NSRect(x: -27.78, y: -29.06, width: 55.55, height: 58.11)
        let ovalPath = NSBezierPath()
        ovalPath.appendArc(withCenter: NSPoint(x: 0, y: 0), radius: ovalRect.width / 2, startAngle: -91, endAngle: -39, clockwise: true)
        
        var ovalTransform = AffineTransform()
        ovalTransform.translate(x: ovalRect.midX, y: ovalRect.midY)
        ovalTransform.scale(x: 1, y: ovalRect.height / ovalRect.width)
        ovalPath.transform(using: ovalTransform)
        
        ColorConstants.SetupComplete.BackupButton.arrowTail?.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.lineCapStyle = .round
        ovalPath.lineJoinStyle = .bevel
        ovalPath.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
        
        //// Polygon Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: -9.65, y: 15.01)
        context.rotate(by: 110.98 * CGFloat.pi/180)
        
        NSGraphicsContext.saveGraphicsState()
        context.setBlendMode(.darken)
        
        let polygonPath = NSBezierPath()
        polygonPath.move(to: NSPoint(x: 0, y: 7.39))
        polygonPath.line(to: NSPoint(x: 7.08, y: -3.7))
        polygonPath.line(to: NSPoint(x: -7.08, y: -3.7))
        polygonPath.close()
        clockhandsArrowheadColor?.setFill()
        polygonPath.fill()
        
        NSGraphicsContext.restoreGraphicsState()
        
        NSGraphicsContext.restoreGraphicsState()
        
        context.endTransparencyLayer()
        
        NSGraphicsContext.restoreGraphicsState()
        
        //// Clockhand drawing
        let rectanglePath = NSBezierPath(rect: NSRect(x: frame.minX + 39, y: frame.minY + frame.height - 45, width: 3, height: 21))
        clockhandsArrowheadColor?.setFill()
        rectanglePath.fill()
        arrowTailColor?.setStroke()
        rectanglePath.lineWidth = 0.5
        rectanglePath.lineCapStyle = .round
        rectanglePath.lineJoinStyle = .bevel
        rectanglePath.stroke()
        
        
        //// Clockhand Drawing
        let rectangle2Path = NSBezierPath(rect: NSRect(x: frame.minX + 42, y: frame.minY + frame.height - 48, width: 16.75, height: 3))
        clockhandsArrowheadColor?.setFill()
        rectangle2Path.fill()
        clockhandsArrowheadColor?.setStroke()
        rectangle2Path.lineWidth = 0.5
        rectangle2Path.lineCapStyle = .round
        rectangle2Path.lineJoinStyle = .bevel
        rectangle2Path.stroke()
        
        
        //// Clock Center / Clockhand joining Nut Drawing
        let oval2Path = NSBezierPath(ovalIn: NSRect(x: frame.minX + 38, y: frame.minY + frame.height - 49, width: 6, height: 6))
        clockhandsArrowheadColor?.setFill()
        oval2Path.fill()
        
       
    }
    
    @objc dynamic public class func drawSelfService(frame: NSRect = NSRect(x: 0, y: 0, width: 85, height: 81)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Color Declarations
        let upperLeftColor = ColorConstants.SetupComplete.SelfServiceButton.upperLeft
        let lowerLeftColor = ColorConstants.SetupComplete.SelfServiceButton.lowerLeft
        let lowerRightColor = ColorConstants.SetupComplete.SelfServiceButton.lowerRight
        let upperRightColor = ColorConstants.SetupComplete.SelfServiceButton.upperRight
        let innerRingColor = ColorConstants.SetupComplete.SelfServiceButton.innerRing
        
        //// outer_button_ringPath Drawing
        let outer_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 4, y: frame.minY + frame.height - 79, width: 77, height: 77))
        ColorConstants.SetupComplete.outerRing.setStroke()
        outer_button_ringPath.lineWidth = 1.5
        outer_button_ringPath.lineCapStyle = .round
        outer_button_ringPath.lineJoinStyle = .round
        outer_button_ringPath.stroke()
        
        //// inner_button_ring Drawing
        let inner_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 5, y: frame.minY + frame.height - 78, width: 75, height: 75))
        NSColor.white.setFill()
        inner_button_ringPath.fill()
        innerRingColor?.setStroke()
        inner_button_ringPath.lineWidth = 1.5
        inner_button_ringPath.lineCapStyle = .round
        inner_button_ringPath.lineJoinStyle = .round
        inner_button_ringPath.stroke()
        
        //// Group
        //// Upper Left Corner Shape Drawing
        let bezierPath = NSBezierPath()
        bezierPath.move(to: NSPoint(x: frame.minX + 48.56, y: frame.maxY - 16.38))
        bezierPath.line(to: NSPoint(x: frame.minX + 44.43, y: frame.maxY - 27.83))
        bezierPath.line(to: NSPoint(x: frame.minX + 35.67, y: frame.maxY - 24.69))
        bezierPath.curve(to: NSPoint(x: frame.minX + 34.48, y: frame.maxY - 24.69), controlPoint1: NSPoint(x: frame.minX + 35.67, y: frame.maxY - 24.69), controlPoint2: NSPoint(x: frame.minX + 35.06, y: frame.maxY - 24.39))
        bezierPath.curve(to: NSPoint(x: frame.minX + 33.36, y: frame.maxY - 25.92), controlPoint1: NSPoint(x: frame.minX + 33.9, y: frame.maxY - 25), controlPoint2: NSPoint(x: frame.minX + 33.36, y: frame.maxY - 25.92))
        bezierPath.line(to: NSPoint(x: frame.minX + 30.34, y: frame.maxY - 34.09))
        bezierPath.line(to: NSPoint(x: frame.minX + 18.57, y: frame.maxY - 29.94))
        bezierPath.line(to: NSPoint(x: frame.minX + 23.55, y: frame.maxY - 16.38))
        bezierPath.curve(to: NSPoint(x: frame.minX + 27.54, y: frame.maxY - 12.3), controlPoint1: NSPoint(x: frame.minX + 23.55, y: frame.maxY - 16.38), controlPoint2: NSPoint(x: frame.minX + 24.6, y: frame.maxY - 13.86))
        bezierPath.curve(to: NSPoint(x: frame.minX + 33.36, y: frame.maxY - 11.07), controlPoint1: NSPoint(x: frame.minX + 30.48, y: frame.maxY - 10.73), controlPoint2: NSPoint(x: frame.minX + 33.36, y: frame.maxY - 11.07))
        bezierPath.line(to: NSPoint(x: frame.minX + 48.56, y: frame.maxY - 16.38))
        upperLeftColor?.setFill()
        bezierPath.fill()
        upperLeftColor?.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()
        
        //// Lower Left Corner Shape Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 35.28, y: frame.maxY - 63.51)
        context.rotate(by: 89.3 * CGFloat.pi/180)
        
        let bezier2Path = NSBezierPath()
        bezier2Path.move(to: NSPoint(x: 29.14, y: 18.21))
        bezier2Path.line(to: NSPoint(x: 25.12, y: 6.44))
        bezier2Path.line(to: NSPoint(x: 16.61, y: 9.67))
        bezier2Path.curve(to: NSPoint(x: 15.46, y: 9.67), controlPoint1: NSPoint(x: 16.61, y: 9.67), controlPoint2: NSPoint(x: 16.02, y: 9.98))
        bezier2Path.curve(to: NSPoint(x: 14.37, y: 8.41), controlPoint1: NSPoint(x: 14.89, y: 9.35), controlPoint2: NSPoint(x: 14.37, y: 8.41))
        bezier2Path.line(to: NSPoint(x: 11.44, y: 0))
        bezier2Path.line(to: NSPoint(x: -0, y: 4.27))
        bezier2Path.line(to: NSPoint(x: 4.83, y: 18.21))
        bezier2Path.curve(to: NSPoint(x: 8.72, y: 22.41), controlPoint1: NSPoint(x: 4.83, y: 18.21), controlPoint2: NSPoint(x: 5.86, y: 20.8))
        bezier2Path.curve(to: NSPoint(x: 14.37, y: 23.67), controlPoint1: NSPoint(x: 11.58, y: 24.02), controlPoint2: NSPoint(x: 14.37, y: 23.67))
        bezier2Path.line(to: NSPoint(x: 29.14, y: 18.21))
        lowerLeftColor?.setFill()
        bezier2Path.fill()
        lowerLeftColor?.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.lineCapStyle = .round
        bezier2Path.lineJoinStyle = .round
        bezier2Path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
        
        //// Lower Right Corner Shape Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 65.66, y: frame.maxY - 47.41)
        context.rotate(by: 179.96 * CGFloat.pi/180)
        
        let bezier3Path = NSBezierPath()
        bezier3Path.move(to: NSPoint(x: 29.99, y: 17.71))
        bezier3Path.line(to: NSPoint(x: 25.86, y: 6.27))
        bezier3Path.line(to: NSPoint(x: 17.1, y: 9.4))
        bezier3Path.curve(to: NSPoint(x: 15.91, y: 9.4), controlPoint1: NSPoint(x: 17.1, y: 9.4), controlPoint2: NSPoint(x: 16.49, y: 9.71))
        bezier3Path.curve(to: NSPoint(x: 14.79, y: 8.17), controlPoint1: NSPoint(x: 15.33, y: 9.09), controlPoint2: NSPoint(x: 14.79, y: 8.17))
        bezier3Path.line(to: NSPoint(x: 11.77, y: -0))
        bezier3Path.line(to: NSPoint(x: -0, y: 4.15))
        bezier3Path.line(to: NSPoint(x: 4.98, y: 17.71))
        bezier3Path.curve(to: NSPoint(x: 8.97, y: 21.8), controlPoint1: NSPoint(x: 4.98, y: 17.71), controlPoint2: NSPoint(x: 6.03, y: 20.23))
        bezier3Path.curve(to: NSPoint(x: 14.79, y: 23.02), controlPoint1: NSPoint(x: 11.91, y: 23.36), controlPoint2: NSPoint(x: 14.79, y: 23.02))
        bezier3Path.line(to: NSPoint(x: 29.99, y: 17.71))
        lowerRightColor?.setFill()
        bezier3Path.fill()
        lowerRightColor?.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.lineCapStyle = .round
        bezier3Path.lineJoinStyle = .round
        bezier3Path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
        
        //// Upper Right Corner Shape Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 48.74, y: frame.maxY - 18.16)
        context.rotate(by: -90.27 * CGFloat.pi/180)
        
        let bezier4Path = NSBezierPath()
        bezier4Path.move(to: NSPoint(x: 29.15, y: 18.22))
        bezier4Path.line(to: NSPoint(x: 25.13, y: 6.45))
        bezier4Path.line(to: NSPoint(x: 16.62, y: 9.67))
        bezier4Path.curve(to: NSPoint(x: 15.46, y: 9.67), controlPoint1: NSPoint(x: 16.62, y: 9.67), controlPoint2: NSPoint(x: 16.02, y: 9.98))
        bezier4Path.curve(to: NSPoint(x: 14.37, y: 8.41), controlPoint1: NSPoint(x: 14.9, y: 9.35), controlPoint2: NSPoint(x: 14.37, y: 8.41))
        bezier4Path.line(to: NSPoint(x: 11.44, y: 0))
        bezier4Path.line(to: NSPoint(x: -0, y: 4.27))
        bezier4Path.line(to: NSPoint(x: 4.84, y: 18.22))
        bezier4Path.curve(to: NSPoint(x: 8.72, y: 22.42), controlPoint1: NSPoint(x: 4.84, y: 18.22), controlPoint2: NSPoint(x: 5.86, y: 20.81))
        bezier4Path.curve(to: NSPoint(x: 14.37, y: 23.68), controlPoint1: NSPoint(x: 11.58, y: 24.03), controlPoint2: NSPoint(x: 14.37, y: 23.68))
        bezier4Path.line(to: NSPoint(x: 29.15, y: 18.22))
        upperRightColor?.setFill()
        bezier4Path.fill()
        upperRightColor?.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.lineCapStyle = .round
        bezier4Path.lineJoinStyle = .round
        bezier4Path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
        
        //// Upper Left Oval Drawing
        let upperLeftOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 36.5, y: frame.minY + frame.height - 36.5, width: 4, height: 4))
        upperLeftColor?.setFill()
        upperLeftOvalPath.fill()
        upperLeftColor?.setStroke()
        upperLeftOvalPath.lineWidth = 1
        upperLeftOvalPath.stroke()
        
        //// Upper Right Oval Drawing
        let upperRightOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 46.5, y: frame.minY + frame.height - 40, width: 4, height: 4))
        upperRightColor?.setFill()
        upperRightOvalPath.fill()
        upperRightColor?.setStroke()
        upperRightOvalPath.lineWidth = 1
        upperRightOvalPath.stroke()
        
        //// Oval 6 Drawing
        let lowerLeftOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 32.5, y: frame.minY + frame.height - 46, width: 4, height: 4))
        lowerLeftColor?.setFill()
        lowerLeftOvalPath.fill()
        lowerLeftColor?.setStroke()
        lowerLeftOvalPath.lineWidth = 1
        lowerLeftOvalPath.stroke()
        
        //// Oval 7 Drawing
        let lowerRightOvalPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 43, y: frame.minY + frame.height - 50, width: 4, height: 4))
        lowerRightColor?.setFill()
        lowerRightOvalPath.fill()
        lowerRightColor?.setStroke()
        lowerRightOvalPath.lineWidth = 1
        lowerRightOvalPath.stroke()
        
        
    }

    
    @objc dynamic public class func qna(frame: NSRect = NSRect(x: 0, y: 0, width: 85, height: 81)) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Color Declarations
        let helpBubbleStrokeColor = ColorConstants.SetupComplete.HelpButton.bubbleStroke
        let windowBackgroundColor = ColorConstants.SetupComplete.HelpButton.windowBackground
        let checkmarkColor = ColorConstants.SetupComplete.HelpButton.checkmark
        let innerRingColor = ColorConstants.SetupComplete.HelpButton.innerRing
        
        //// outer_button_ring Drawing
        let outer_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 4, y: frame.minY + frame.height - 79, width: 77, height: 77))
        ColorConstants.SetupComplete.outerRing.setStroke()
        outer_button_ringPath.lineWidth = 1.5
        outer_button_ringPath.lineCapStyle = .round
        outer_button_ringPath.lineJoinStyle = .round
        outer_button_ringPath.stroke()
        
        //// inner_button_ring Drawing
        let inner_button_ringPath = NSBezierPath(ovalIn: NSRect(x: frame.minX + 5, y: frame.minY + frame.height - 78, width: 75, height: 75))
        NSColor.white.setFill()
        inner_button_ringPath.fill()
        innerRingColor?.setStroke()
        inner_button_ringPath.lineWidth = 1.5
        inner_button_ringPath.lineCapStyle = .round
        inner_button_ringPath.lineJoinStyle = .round
        inner_button_ringPath.stroke()
        
        //// Rectangle Drawing
        let rectanglePath = NSBezierPath()
        rectanglePath.move(to: NSPoint(x: frame.minX + 18, y: frame.maxY - 30.66))
        rectanglePath.curve(to: NSPoint(x: frame.minX + 21.19, y: frame.maxY - 33.83), controlPoint1: NSPoint(x: frame.minX + 18, y: frame.maxY - 32.41), controlPoint2: NSPoint(x: frame.minX + 19.43, y: frame.maxY - 33.83))
        rectanglePath.line(to: NSPoint(x: frame.minX + 43.53, y: frame.maxY - 33.83))
        rectanglePath.line(to: NSPoint(x: frame.minX + 49.51, y: frame.maxY - 37))
        rectanglePath.curve(to: NSPoint(x: frame.minX + 46.72, y: frame.maxY - 30.66), controlPoint1: NSPoint(x: frame.minX + 51.51, y: frame.maxY - 35.81), controlPoint2: NSPoint(x: frame.minX + 46.72, y: frame.maxY - 32.41))
        rectanglePath.line(to: NSPoint(x: frame.minX + 46.72, y: frame.maxY - 17.17))
        rectanglePath.curve(to: NSPoint(x: frame.minX + 43.53, y: frame.maxY - 14), controlPoint1: NSPoint(x: frame.minX + 46.72, y: frame.maxY - 15.42), controlPoint2: NSPoint(x: frame.minX + 45.29, y: frame.maxY - 14))
        rectanglePath.line(to: NSPoint(x: frame.minX + 21.19, y: frame.maxY - 14))
        rectanglePath.curve(to: NSPoint(x: frame.minX + 18, y: frame.maxY - 17.17), controlPoint1: NSPoint(x: frame.minX + 19.43, y: frame.maxY - 14), controlPoint2: NSPoint(x: frame.minX + 18, y: frame.maxY - 15.42))
        rectanglePath.line(to: NSPoint(x: frame.minX + 18, y: frame.maxY - 30.66))
        rectanglePath.close()
        windowBackgroundColor?.setFill()
        rectanglePath.fill()
        helpBubbleStrokeColor?.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        
        //// Bezier Drawing
        let bezierPath = NSBezierPath()
        windowBackgroundColor?.setFill()
        bezierPath.fill()
        helpBubbleStrokeColor?.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        //// Rectangle 3 Drawing
        let rectangle3Path = NSBezierPath()
        rectangle3Path.move(to: NSPoint(x: frame.minX + 69, y: frame.maxY - 59.38))
        rectangle3Path.curve(to: NSPoint(x: frame.minX + 65.91, y: frame.maxY - 62.69), controlPoint1: NSPoint(x: frame.minX + 69, y: frame.maxY - 61.21), controlPoint2: NSPoint(x: frame.minX + 67.62, y: frame.maxY - 62.69))
        rectangle3Path.line(to: NSPoint(x: frame.minX + 44.27, y: frame.maxY - 62.69))
        rectangle3Path.line(to: NSPoint(x: frame.minX + 38.47, y: frame.maxY - 66))
        rectangle3Path.curve(to: NSPoint(x: frame.minX + 41.18, y: frame.maxY - 59.38), controlPoint1: NSPoint(x: frame.minX + 36.54, y: frame.maxY - 64.76), controlPoint2: NSPoint(x: frame.minX + 41.18, y: frame.maxY - 61.21))
        rectangle3Path.line(to: NSPoint(x: frame.minX + 41.18, y: frame.maxY - 45.31))
        rectangle3Path.curve(to: NSPoint(x: frame.minX + 44.27, y: frame.maxY - 42), controlPoint1: NSPoint(x: frame.minX + 41.18, y: frame.maxY - 43.48), controlPoint2: NSPoint(x: frame.minX + 42.56, y: frame.maxY - 42))
        rectangle3Path.line(to: NSPoint(x: frame.minX + 65.91, y: frame.maxY - 42))
        rectangle3Path.curve(to: NSPoint(x: frame.minX + 69, y: frame.maxY - 45.31), controlPoint1: NSPoint(x: frame.minX + 67.62, y: frame.maxY - 42), controlPoint2: NSPoint(x: frame.minX + 69, y: frame.maxY - 43.48))
        rectangle3Path.line(to: NSPoint(x: frame.minX + 69, y: frame.maxY - 59.38))
        rectangle3Path.close()
        windowBackgroundColor?.setFill()
        rectangle3Path.fill()
        helpBubbleStrokeColor?.setStroke()
        rectangle3Path.lineWidth = 2
        rectangle3Path.stroke()
        
        //// checkmark Drawing
        let checkmarkPath = NSBezierPath()
        checkmarkPath.move(to: NSPoint(x: frame.minX + 49, y: frame.maxY - 54.33))
        checkmarkPath.line(to: NSPoint(x: frame.minX + 54.6, y: frame.maxY - 59))
        checkmarkPath.line(to: NSPoint(x: frame.minX + 61, y: frame.maxY - 45))
        checkmarkColor?.setStroke()
        checkmarkPath.lineWidth = 2
        checkmarkPath.lineCapStyle = .round
        checkmarkPath.lineJoinStyle = .round
        checkmarkPath.stroke()
        
        //// questionMark Drawing
        let questionMarkRect = NSRect(x: frame.minX + 28, y: frame.minY + frame.height - 33, width: 11, height: 18)
        NSGraphicsContext.saveGraphicsState()
        questionMarkRect.clip()
        context.translateBy(x: questionMarkRect.minX, y: questionMarkRect.minY)
        
        SetupCompleteButtons.drawQuestion(frame: CGRect(origin: .zero, size: questionMarkRect.size), resizing: .stretch)
        NSGraphicsContext.restoreGraphicsState()
        
        
    }

    
    @objc dynamic public class func drawQuestion(frame targetFrame: NSRect = NSRect(x: 0, y: 0, width: 11, height: 18), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Resize to Target Frame
        NSGraphicsContext.saveGraphicsState()
        let resizedFrame: NSRect = resizing.apply(rect: NSRect(x: 0, y: 0, width: 11, height: 18), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 11, y: resizedFrame.height / 18)
        
        //// Color Declarations
        let questionMarkColor = ColorConstants.SetupComplete.HelpButton.questionMark
        
        //// Text Drawing
        let textRect = NSRect(x: 0, y: 0, width: 11, height: 18)
        let textTextContent = "?"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont.boldSystemFont(ofSize: 17),
            .foregroundColor: questionMarkColor as Any,
            .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes).height
        let textTextRect: NSRect = NSRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight)
        NSGraphicsContext.saveGraphicsState()
        textRect.clip()
        textTextContent.draw(in: textTextRect.offsetBy(dx: 0, dy: 0.5), withAttributes: textFontAttributes)
        NSGraphicsContext.restoreGraphicsState()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    @objc dynamic public class func drawAppleLogo(frame targetFrame: NSRect = NSRect(x: 0, y: 0, width: 24, height: 24), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Resize to Target Frame
        NSGraphicsContext.saveGraphicsState()
        let resizedFrame: NSRect = resizing.apply(rect: NSRect(x: 0, y: 0, width: 24, height: 24), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 24, y: resizedFrame.height / 24)
        
        //// Color Declarations
        let apple_logo_color = ColorConstants.SetupComplete.appleLogo
        //// Label Drawing
        let labelRect = NSRect(x: 0, y: 0, width: 24, height: 24)
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .left
        let labelFontAttributes = [
            .font: NSFont(name: "Helvetica-Light", size: 24)!,
            .foregroundColor: apple_logo_color as Any,
            .paragraphStyle: labelStyle,
            ] as [NSAttributedString.Key: Any]
        
        "".draw(in: labelRect.offsetBy(dx: 0, dy: 0), withAttributes: labelFontAttributes)
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    @objc dynamic public class func drawWebURL(frame targetFrame: NSRect = NSRect(x: 0, y: 0, width: 52, height: 15), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        //// Resize to Target Frame
        NSGraphicsContext.saveGraphicsState()
        let resizedFrame: NSRect = resizing.apply(rect: NSRect(x: 0, y: 0, width: 52, height: 15), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 52, y: resizedFrame.height / 15)
        
        
        //// Color Declarations
        let textForeground = NSColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
        
        //// Text Drawing
        let textRect = NSRect(x: 0, y: 0, width: 52, height: 15)
        let textTextContent = "https://"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize),
            .foregroundColor: textForeground,
            .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes).height
        let textTextRect: NSRect = NSRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight)
        NSGraphicsContext.saveGraphicsState()
        textRect.clip()
        textTextContent.draw(in: textTextRect.offsetBy(dx: 0, dy: 0.5), withAttributes: textFontAttributes)
        NSGraphicsContext.restoreGraphicsState()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    
    @objc(SetupCompleteScreenButtonsResizingBehavior)
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
    
    @objc dynamic public class var imageOfMigrationButton: NSImage {
        if Cache.imageOfMigrationButton != nil {
            return Cache.imageOfMigrationButton!
        }
        
        Cache.imageOfMigrationButton = NSImage(size: NSSize(width: 85, height: 81), flipped: false) { _ in
            SetupCompleteButtons.drawMigration()
            
            return true
        }
        
        return Cache.imageOfMigrationButton!
    }
    
    @objc dynamic public class var imageOfSelfServiceButton: NSImage {
        if Cache.imageOfSelfServiceButton != nil {
            return Cache.imageOfSelfServiceButton!
        }
        
        Cache.imageOfSelfServiceButton = NSImage(size: NSSize(width: 85, height: 81), flipped: false) { _ in
            SetupCompleteButtons.drawSelfService()
            
            return true
        }
        
        return Cache.imageOfSelfServiceButton!
    }
    
    @objc dynamic public class var imageOfBackupButton: NSImage {
        if Cache.imageOfBackupButton != nil {
            return Cache.imageOfBackupButton!
        }
        
        Cache.imageOfBackupButton = NSImage(size: NSSize(width: 85, height: 81), flipped: false) { _ in
            SetupCompleteButtons.drawBackup()
            return true
        }
        
        return Cache.imageOfBackupButton!
    }
    
    @objc dynamic public class var imageOfURLButton: NSImage {
        if Cache.imageOfURLButton != nil {
            return Cache.imageOfURLButton!
        }
        
        Cache.imageOfURLButton = NSImage(size: NSSize(width: 85, height: 81), flipped: false) { _ in
            SetupCompleteButtons.drawHelp()
            return true
        }
        
        return Cache.imageOfURLButton!
    }
    
    @objc dynamic public class var imageOfQnAButton: NSImage {
        if Cache.imageOfQnAButton != nil {
            return Cache.imageOfQnAButton!
        }
        
        Cache.imageOfQnAButton = NSImage(size: NSSize(width: 85, height: 81), flipped: false) { _ in
            SetupCompleteButtons.qna()
            return true
        }
        
        return Cache.imageOfQnAButton!
    }
}
