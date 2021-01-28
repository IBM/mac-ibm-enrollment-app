//
//  CrossfadeStoryBoardSegue.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// Override for StoryBoardSegue to control the animation of transitioning between views.
class CrossfadeStoryBoardSegue: NSStoryboardSegue {
    override func perform() {
        guard let sourceViewController = self.sourceController as? NSViewController,
            let destinationViewController = self.destinationController as? NSViewController else { return }
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
        case "goToPage" :
            transitionOption = NSViewController.TransitionOptions.slideForward
        case "backFromPage" :
            transitionOption = NSViewController.TransitionOptions.slideBackward
        case "goToFirstRegistrationPage" :
            transitionOption = NSViewController.TransitionOptions.slideForward
        case "backToRegistrationFinalPage" :
            transitionOption = NSViewController.TransitionOptions.slideBackward
        case "goToPostRegistrationPage":
            transitionOption = NSViewController.TransitionOptions.slideForward
        case "goToInstallationPage":
            transitionOption = NSViewController.TransitionOptions.slideForward
        case "goToPostInstallationPage":
            transitionOption = NSViewController.TransitionOptions.slideForward
        case "goToFilePickerPage":
            transitionOption = NSViewController.TransitionOptions.slideUp
        case "backFromFilePickerPage":
            transitionOption = NSViewController.TransitionOptions.slideDown
        case "goToInstallationPhase":
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
