//
//  DropdownTextField.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import DropDown

class DropdownTextField: TextField {
    private lazy var dropdown = DropDown()
    private var dataSource = [DropdownItem]()

    private var isExpanded: Bool = false {
        didSet {
            (rightView as? UIImageView )?.isHighlighted = isExpanded

        }
    }

    var onItemSelected: (() -> Void)?
    var selectedItem: DropdownItem? {
        didSet {
            onItemSelected?()
        }
    }

    private var items = [DropdownItem]() {
        didSet {
            setupDropdown()
            dataSource.append(contentsOf: items)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: frame.width - 26, y: (frame.height / 2) - 2.5, width: 10, height: 5)
    }

    func configure(with items: [DropdownItem]) {
        self.items = items
    }
}

// MARK: - PrivateHelperMethods
private extension DropdownTextField {
    func configureViews() {
        let dropDownImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        dropDownImageView.image = UIImage(named: "icon-arrow-down")
        dropDownImageView.highlightedImage = UIImage(named: "icon-arrow-up")
        rightView = dropDownImageView
        rightViewMode = .always
        tintColor = .purple
        delegate = self
    }

    func setupDropdown() {
        DropdownStyle.initialize()
        dropdown.dismissMode = .automatic
        dropdown.anchorView = self
        dropdown.direction = .bottom
        dropdown.bottomOffset = CGPoint(x: 0, y: frame.height)
        dropdown.width = frame.width
        dropdown.dataSource = items.compactMap { $0.title }
            dropdown.selectionAction = { [unowned self] index, text in
                self.text = text
                self.selectedItem = self.items[index]
                self.isExpanded = !self.isExpanded
            }
    }
}

// MARK: - UITextFieldDelegate
extension DropdownTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isExpanded = !isExpanded
        if !items.isEmpty, isExpanded {
            dropdown.show()
            superview?.endEditing(true)
        } else {
            dropdown.hide()
        }
        return false
    }
}
