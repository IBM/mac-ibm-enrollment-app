//
//  StackView.swift
//  enrollment
//
//  Created by Jay on 8/22/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

protocol StackItemHost: class {
    func disclose(_ stackItem: StackItemContainer)
}

protocol StackItemHeader: class {
    var viewController: NSViewController { get }
    var disclose: (() -> ())? { get set }
    func update(toDiscloseState: StackItemContainer.DiscloseState)
}

protocol StackItemBody: class {
    var viewController: NSViewController { get }
    func show(animated: Bool)
    func hide(animated: Bool)
}

extension StackItemHost {
    func disclose(_ stackItem: StackItemContainer) {
        switch stackItem.state {
        case .open:
            hide(stackItem, animated: true)
            stackItem.state = .closed
        case .closed:
            show(stackItem, animated: true)
            stackItem.state = .open
        }
        stackItem.header.update(toDiscloseState: stackItem.state)
    }
    
    func show(_ stackItem: StackItemContainer, animated: Bool) {
        stackItem.body.show(animated: animated)
        stackItem.header.update(toDiscloseState: .open)
    }
    
    func hide(_ stackItem: StackItemContainer, animated: Bool) {
        stackItem.body.hide(animated: animated)
        stackItem.header.update(toDiscloseState: .closed)
    }
}

extension StackItemHeader where Self: NSViewController {
    var viewController: NSViewController { return self }
}

extension StackItemBody where Self: NSViewController {
    var viewController: NSViewController { return self }
    func animateDisclosure(disclose: Bool, animated: Bool) {
        let viewController = self as! BaseViewController
        if let constraint = viewController.bundleProgressStackHeightConstraint {
            let heightValue = disclose ? viewController.savedDefaultHeight : 0
            
            if animated {
                NSAnimationContext.runAnimationGroup({ (context) -> Void in
                    context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    constraint.animator().constant = heightValue
                }, completionHandler: {
                    () -> Void in
                })
            } else {
                constraint.constant = heightValue
            }
        }
    }
    
    func show(animated: Bool) {
        animateDisclosure(disclose: true, animated: animated)
    }
    
    func hide(animated: Bool) {
        animateDisclosure(disclose: false, animated: animated)
    }
}
    
    
    class StackItemContainer {
        enum DiscloseState: Int {
            case open = 0
            case closed = 1
        }
        
        let header: StackItemHeader
        var state: DiscloseState
        let body: StackItemBody
        
        init(header: StackItemHeader, body: StackItemBody, state: DiscloseState) {
            self.header = header
            self.body = body
            self.state = state
        }
}
