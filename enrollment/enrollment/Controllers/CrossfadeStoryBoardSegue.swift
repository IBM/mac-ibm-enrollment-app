//
//  CrossfadeStoryBoardSegue.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

/*
 Override for StoryBoardSegue to control the animation of transitioning between views. Full string values or stored in `DestinationIDConstants` referenced from interface builder.
 */

class CrossfadeStoryBoardSegue: NSStoryboardSegue {
    override init(identifier: NSStoryboardSegue.Identifier, source sourceController: Any, destination destinationController: Any) {
        var myIdentifier: String
        
        myIdentifier = identifier
        
        super.init(identifier: myIdentifier, source: sourceController, destination: destinationController)
    }
    
    override func perform() {
        let sourceViewController = self.sourceController as! NSViewController
        let destinationViewController = self.destinationController as! NSViewController
        let destinationID = self.identifier
        let containerViewController = sourceViewController.parent
        
        containerViewController?.insertChild(destinationViewController, at: 1)
        
        let targetSize = destinationViewController.view.frame.size
        _ = destinationViewController.view.frame.size.width
        _ = destinationViewController.view.frame.size.height
        
        sourceViewController.view.wantsLayer = true
        destinationViewController.view.wantsLayer = true
        
        var transitionOption = NSViewController.TransitionOptions.slideForward
        
        switch destinationID {
        case SegueDestinationID.ReturnTo.primaryRegistrationChildViewController? :
            transitionOption = NSViewController.TransitionOptions.slideBackward
        case SegueDestinationID.SkipTo.setupCompleteChildViewConroller? :
            transitionOption = NSViewController.TransitionOptions.crossfade
        default :
            transitionOption = NSViewController.TransitionOptions.slideForward
        }
        
        containerViewController?.transition(from: sourceViewController, to: destinationViewController,
                                            options: transitionOption, completionHandler: nil)
        
        sourceViewController.view.animator().setFrameSize(targetSize)
        destinationViewController.view.animator().setFrameSize(targetSize)
        
        _ = containerViewController?.view.window?.frame
        
        containerViewController?.removeChild(at: 0)
    }
}
