//
//  ExtendedRegistrationField.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/25/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the extended registration field cell. This kind of cell is used when the user needs to display field where multiple option selection is allowed.
class ExtendedRegistrationField: NSCollectionViewItem {

    // MARK: - Outlets
    
    @IBOutlet var fieldTitle: InfoLabelView!
    @IBOutlet var optionsStackView: NSStackView!
    
    // MARK: - Variables
    
    weak var delegate: SelectableRegistrationCollectionViewItemDelegate?
    static var reuseIdentifier = NSUserInterfaceItemIdentifier("ExtendedRegistrationField")
    
    private var selectedChoises: [RegistrationField.Option] = []
    private var isExclusiveOptionSelected: Bool = false
    
    var selectedOptions: [String] = []
    var fieldInfo: RegistrationField? 
    
    // MARK: - Public methods
    
    /// Use this method to configure the cell with the given field and the selected options if applicable.
    /// - Parameters:
    ///   - field: the registration field that the cell should show.
    ///   - selectedOptions: the already selected option keys if applicable (default value: empty array).
    func configure(with field: RegistrationField, selectedOptions: [String] = []) {
        self.fieldInfo = field
        self.selectedOptions = selectedOptions
        
        fieldTitle.labelledInfo = field.title
        if let helpInfos = field.title.infoSection {
            fieldTitle.onInfoButtonPressed = { view in
                self.delegate?.didPressedInfoButton(view, infos: helpInfos)
            }
        }
        fieldTitle.isHidden = !(fieldInfo?.showTitle ?? false)
        
        for option in field.options {
            let optionView = ExtendedRegistrationFieldItem(frame: .zero)
            optionView.fieldOption = option
            optionView.isSelected = selectedOptions.contains(option.label)
            if (option.isExclusive ?? false) && optionView.isSelected {
                isExclusiveOptionSelected = true
            }
            optionView.onSelection = { option, newState in
                switch newState {
                case .on:
                    if (option.isExclusive ?? false) || self.isExclusiveOptionSelected {
                        self.isExclusiveOptionSelected.toggle()
                        self.resetSelectedOptions(except: option.label)
                    }
                    self.selectedOptions.append(option.label)
                case .off:
                    self.selectedOptions.removeAll(where: { $0 == option.label })
                default:
                    break
                }
                self.callOptionsUpdate()
            }
            self.optionsStackView.addArrangedSubview(optionView)
        }
    }
    
    // MARK: - Private methods
    
    /// Use this method to reset the array of the selected options when the caller (exclusive selection field option) is selected.
    /// - Parameter caller: the exclusive selected option.
    private func resetSelectedOptions(except caller: String) {
        selectedOptions.removeAll()
        for item in optionsStackView.arrangedSubviews {
            guard let item = item as? ExtendedRegistrationFieldItem,
                item.fieldOption?.label != caller else { continue }
            item.isSelected = false
        }
    }
    
    /// This method is called when a new selection is made on the field. 
    private func callOptionsUpdate() {
        guard let info = fieldInfo else { return }
        if selectedOptions.isEmpty {
            delegate?.didDeselectOption(RegistrationChoice.init(info.key, fieldTitle: info.title.label, selectedOptionKeys: [], selectedOptionTitles: []))
        } else {
            let selectedOptionTitles = selectedOptions
            var selectedOptionKeys: [String] = []
            for title in selectedOptionTitles {
                guard let index = info.optionLabels.firstIndex(of: title),
                    index < info.optionKeys.count else { continue }
                selectedOptionKeys.append(info.optionKeys[index])
            }
            delegate?.didSelectedOption(self, option: RegistrationChoice(info.key, fieldTitle: info.title.label, selectedOptionKeys: selectedOptionKeys, selectedOptionTitles: selectedOptionTitles, isMultipleChoiseAllowed: true))
        }
    }
    
}
