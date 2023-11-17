//
//  CustomTextField.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 16.11.2023.
//

import UIKit

open class RoundedTextField: UITextField {
    
    func setupInitialState() {
        self.backgroundColor = .none
        self.textColor = .black
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.customGray.cgColor
        self.layer.cornerRadius = 20
        self.attributedPlaceholder = NSAttributedString(string: "=", attributes:[NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialState()
    }
}
