//
//  MultipleRegistrationFieldsViewController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/3/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the view controller that shows multiple registration fields to the user.
class MultipleRegistrationFieldsViewController: NSViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contentView: NSView!
    @IBOutlet weak var titleLabel: InfoLabelView!
    @IBOutlet weak var subtitleLabel: InfoLabelView!
    @IBOutlet weak var footerLabel: InfoLabelView!
    @IBOutlet weak var fieldsCollectionView: NSCollectionView!
    @IBOutlet weak var bottomLeftButton: NSButton!
    @IBOutlet weak var bottomRightButton: NSButton! {
        didSet {
            bottomRightButton?.isEnabled = canGoThrough()
        }
    }
    
    // MARK: - Variables
    
    static let controllerID = "MultipleRegistrationFieldsViewController"
    private var _page: RegistrationPage?
    var page: RegistrationPage! {
        get {
            guard _page != nil else {
                return Context.main!.dataSet.registration?.pages.first! // If the page was not setted at the viewController init it takes the first registration page of the main context.
            }
            return _page
        }
        set {
            _page = newValue
        }
    }
    var registrationChoices: Set<RegistrationChoice> = .init() {
        didSet {
            bottomRightButton?.isEnabled = canGoThrough()
        }
    }
    
    // MARK: - Instance methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadChoices()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        configureLabels()
        configureButtons()
    }

    // MARK: - Overriding methods
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToPage":
            guard let nexVC = segue.destinationController as? MultipleRegistrationFieldsViewController else { return }
            guard let context = Context.main,
                let currentIndexPage = context.dataSet.registration?.pages.firstIndex(of: self.page),
                let count = context.dataSet.registration?.pages.count, count > currentIndexPage+1 else { return }
            let nextPage = context.dataSet.registration?.pages[currentIndexPage+1]
            nexVC.page = nextPage
            nexVC.registrationChoices = self.registrationChoices
        case "backFromPage":
            guard let nexVC = segue.destinationController as? MultipleRegistrationFieldsViewController else { return }
            guard let context = Context.main,
                let currentIndexPage = context.dataSet.registration?.pages.firstIndex(of: self.page),
                currentIndexPage > 0 else { return }
            let nextPage = context.dataSet.registration?.pages[currentIndexPage-1]
            nexVC.page = nextPage
            nexVC.registrationChoices = self.registrationChoices
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    private func configureCollectionView() {
        fieldsCollectionView.register(NSNib(nibNamed: "CompactRegistrationField", bundle: nil), forItemWithIdentifier: CompactRegistrationField.reuseIdentifier)
        fieldsCollectionView.register(NSNib(nibNamed: "ExtendedRegistrationField", bundle: nil), forItemWithIdentifier: ExtendedRegistrationField.reuseIdentifier)
    }
    
    private func configureLabels() {
        titleLabel.labelledInfo = page.title
        titleLabel.font = .systemFont(ofSize: 28)
        if let titleHelp = page.title.infoSection {
            titleLabel.onInfoButtonPressed = { view in
                self.didPressedInfoButton(view, infos: titleHelp)
            }
        }

        if let subtitle = page.subtitle {
            subtitleLabel.labelledInfo = subtitle
            if let subtitleHelp = subtitle.infoSection {
                subtitleLabel.onInfoButtonPressed = { view in
                    self.didPressedInfoButton(view, infos: subtitleHelp)
                }
            }
        }

        if let footer = page.footer {
            footerLabel.labelledInfo = footer
            if let footerHelp = footer.infoSection {
                footerLabel.onInfoButtonPressed = { view in
                    self.didPressedInfoButton(view, infos: footerHelp)
                }
            }
        } else {
            footerLabel.isHidden = true
        }
    }
    
    private func configureButtons() {
        guard let context = Context.main,
            let currentIndexPage = context.dataSet.registration?.pages.firstIndex(of: self.page)else { return }
        
        switch context.dataSet.phase {
        case "3":
            bottomLeftButton.isHidden = !(context.dataSet.registration?.registrationStatus ?? false)
            bottomLeftButton.title = "buttonLabelBack".localized
            bottomRightButton.title = "buttonLabelNext".localized
        default:
            bottomLeftButton.title = currentIndexPage > 0 ? "buttonLabelBack".localized : "buttonLabelUnenroll".localized
            bottomRightButton.title = "buttonLabelNext".localized
        }
    }
    
    /// If not defined at viewController init it load the user registration choices from the main context.
    private func loadChoices() {
        guard registrationChoices.isEmpty, let choices = Context.main?.dataSet.selectedRegistrationInfo else { return }
        choices.forEach({ self.registrationChoices.insert($0) })
    }
    
    /// Check if all the fields have a selected choice.
    /// - Returns: bool value.
    private func canGoThrough() -> Bool {
        let regChoisesKeys = registrationChoices.map({ $0.fieldKey })
        let pageFieldKeys = page.fields.map({ $0.key })
        for key in pageFieldKeys {
            guard regChoisesKeys.contains(key) else { return false }
        }
        return true
    }
    
    private func didRequestCancelFramework() {
        IssueAlertService.sharedInstance.displaySheetWithJAMFAction(header: AlertText.RegistrationCancelAlert.header,
                                                                    message: AlertText.RegistrationCancelAlert.message,
                                                                    style: .critical,
                                                                    cancelButtonLabel: "labelNo".localized,
                                                                    actionButtonLabel: "labelYes".localized,
                                                                    jamfPolicyEvent: Context.main?.dataSet.policies.removeFramework ?? "",
                                                                    button1LogText: "unenrollmentCancelled".localized)
    }
    
    // MARK: - Actions
    
    @IBAction func didPressedBottomLeftButton(_ sender: Any) {
        guard let context = Context.main else { return }
        guard let currentIndexPage = context.dataSet.registration?.pages.firstIndex(of: self.page),
            currentIndexPage > 0 else {
                if context.dataSet.phase == "3" {
                    self.performSegue(withIdentifier: .init("backToRegistrationFinalPage"), sender: nil)
                } else {
                    didRequestCancelFramework()
                }
                return
        }
        self.performSegue(withIdentifier: .init("backFromPage"), sender: nil)
    }
    
    @IBAction func didPressedBottomRightButton(_ sender: Any) {
        
        guard let context = Context.main,
            let currentIndexPage = context.dataSet.registration?.pages.firstIndex(of: self.page) else { return }
        
        guard let count = context.dataSet.registration?.pages.count, count > currentIndexPage+1 else {
            context.dataSet.selectedRegistrationInfo = registrationChoices.map({ $0 })
            self.performSegue(withIdentifier: .init("goToLoadingPage"), sender: nil)
            return
        }
        self.performSegue(withIdentifier: .init("goToPage"), sender: nil)
    }
}

// MARK: - Collection View delegate and data source

extension MultipleRegistrationFieldsViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return page.fields.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let field = page.fields[indexPath.item]
        if field.multipleChoiseAllowed {
            guard let item = fieldsCollectionView.makeItem(withIdentifier: ExtendedRegistrationField.reuseIdentifier, for: indexPath) as? ExtendedRegistrationField else { return NSCollectionViewItem() }
            item.configure(with: field, selectedOptions: registrationChoices.first(where: { $0.fieldKey == field.key })?.selectedOptionTitles ?? [])
            item.delegate = self
            return item
        } else {
            guard let item = fieldsCollectionView.makeItem(withIdentifier: CompactRegistrationField.reuseIdentifier, for: indexPath) as? CompactRegistrationField else { return NSCollectionViewItem() }
            item.fieldInfo = field
            item.selectedOption = registrationChoices.first(where: { $0.fieldKey == field.key })?.selectedOptionTitles.first
            item.delegate = self
            return item
        }

    }
}

// MARK: - Collection View flow layout delegate

extension MultipleRegistrationFieldsViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        let field = page.fields[indexPath.item]
        if field.multipleChoiseAllowed {
            let height: CGFloat = CGFloat(field.optionLabels.count)*25+25
            return NSSize(width: collectionView.bounds.size.width/1.10, height: height)
        } else {
            return NSSize(width: collectionView.bounds.size.width/2.20, height: 60)
        }
    }
}

// MARK: - Registration Field Cell delegate

extension MultipleRegistrationFieldsViewController: SelectableRegistrationCollectionViewItemDelegate {
    func didSelectedOption(_ sender: NSCollectionViewItem, option: RegistrationChoice) {
        self.registrationChoices.remove(option)
        self.registrationChoices.insert(option)
    }

    func didDeselectOption(_ option: RegistrationChoice) {
        self.registrationChoices.remove(option)
    }
    
    func didPressedInfoButton(_ sender: NSButton, infos: InfoSection) {
        let infoPopupViewController = InfoPopOverViewController(with: infos)
        self.present(infoPopupViewController, asPopoverRelativeTo: sender.convert(sender.bounds, to: self.contentView), of: self.contentView, preferredEdge: .maxX, behavior: .semitransient)
    }
}

class MyScroller: NSScroller {
    override var scrollerStyle: NSScroller.Style {
        get {
            return .overlay
        }
        set {
            super.scrollerStyle = newValue
        }
    }
}
