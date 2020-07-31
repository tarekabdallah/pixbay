//
//  TextField.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class TextField: UITextField {

    override var placeholder: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.setPlaceholder(text: self.placeholder)
            }
        }
    }

    var errorHint: String? {
        didSet {
            errorLabel.text = errorHint
        }
    }

    var hasError = false {
        didSet {
            errorLabel.isHidden = !hasError
        }
    }

    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.applyStyle(textColor: .destructive,
                              font: .light,
                              size: .details)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        errorLabel.isHidden = true
        return errorLabel
    }()

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }
}

// MARK: - Private Helper Methods
private extension TextField {
    func configureViews() {
        DispatchQueue.main.async { [weak self] in
            self?.applyStyle(textColor: .purple,
                             backgroundColor: .white,
                             font: .medium,
                             size: .default,
                             cornerRadius: 10)
            self?.borderStyle = .none
            self?.tintColor = .purple
            self?.setBorder(borderColor: .lightGray,
                            borderWidth: 1)
            self?.dropShadow()
            self?.drawBackground()
            self?.errorHint = "tk;bdvndsaklgjfks;'lafmw;l'dsest"
        }
    }
}
