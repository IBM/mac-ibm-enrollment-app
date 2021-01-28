//
//  CompactRegistrationField.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/3/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This protocol describe the interface between the page viewController and the field items
protocol SelectableRegistrationCollectionViewItemDelegate: class {
    func didPressedInfoButton(_ view: NSButton, infos: InfoSection)
    func didSelectedOption(_ sender: NSCollectionViewItem, option: RegistrationChoice)
    func didDeselectOption(_ option: RegistrationChoice)
}

/// This class manage the compact registration field.
class CompactRegistrationField: NSCollectionViewItem {
    
    // MARK: - Outlets
    
    @IBOutlet weak var fieldOptionsMenu: NSPopUpButton!
    @IBOutlet weak var fieldLabel: InfoLabelView!
    
    // MARK: - Variables
    
    weak var delegate: SelectableRegistrationCollectionViewItemDelegate?
    static var reuseIdentifier = NSUserInterfaceItemIdentifier("CompactRegistrationField")
    var selectedOption: String? {
        didSet {
            if let option = selectedOption {
                self.fieldOptionsMenu.selectItem(withTitle: option.localized)
            }
        }
    }
    var fieldInfo: RegistrationField? {
        didSet {
            guard let info = fieldInfo else { return }
            self.fieldLabel.labelledInfo = info.title
            self.fieldOptionsMenu.addItem(withTitle: "")
            self.fieldOptionsMenu.addItems(withTitles: info.optionLabels.map({ $0.localized }))
            guard let help = info.title.infoSection else { return }
            self.fieldLabel.onInfoButtonPressed = { view in
                self.delegate?.didPressedInfoButton(view, infos: help)
            }
        }
    }

    // MARK: - Actions
    
    @IBAction func didSelectedOption(_ sender: NSPopUpButton) {
        guard let fieldInfo = fieldInfo,
            let selectedOptionTitle = sender.selectedItem?.title,
            !selectedOptionTitle.isEmpty,
            let selectedOptionTitleIndex = fieldInfo.optionLabels.map({ $0.localized }).firstIndex(of: selectedOptionTitle),
            selectedOptionTitleIndex < fieldInfo.optionKeys.count else {
                delegate?.didDeselectOption(RegistrationChoice(self.fieldInfo?.key ?? "",
                                                               fieldTitle: "",
                                                               selectedOptionKeys: [],
                                                               selectedOptionTitles: []))
                return
        }
        let selectedOptionKey = fieldInfo.optionKeys[selectedOptionTitleIndex]
        let registrationChoise = RegistrationChoice(fieldInfo.key,
                                                    fieldTitle: fieldInfo.title.label,
                                                    selectedOptionKeys: [selectedOptionKey],
                                                    selectedOptionTitles: [selectedOptionTitle])
        delegate?.didSelectedOption(self, option: registrationChoise)
    }
}
