//
//  BaseViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/22/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class BaseViewController: NSViewController, StackItemBody {
    
    @IBOutlet var bundleProgressStackHeightConstraint: NSLayoutConstraint!
    
    var savedDefaultHeight: CGFloat = 0
    var discloseState: StackItemContainer.DiscloseState = .closed
    
    func headerTitle() -> String { return "" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedDefaultHeight = view.bounds.height
    }
    
    lazy var stackItemContainer: StackItemContainer? = {
        var storyboardIdentifier: String
            storyboardIdentifier = "HeaderViewController"
        let storyboard = NSStoryboard(name: "HeaderViewController", bundle: nil)
        guard let header = storyboard.instantiateController(withIdentifier: storyboardIdentifier) as? HeaderViewController else {
            return .none
        }
        header.title = self.headerTitle()
        
        return StackItemContainer(header: header, body: self, state: self.discloseState)
    }()
    
}
