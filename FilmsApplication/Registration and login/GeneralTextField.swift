//
//  GeneralTextField.swift
//  FilmsApplication
//
//  Created by Kamil on 19.07.2023.
//

import UIKit

final class GeneralTextField: UITextField {
    
    //MARK: Private property
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    
    //MARK: Initializers
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: Settings
    private func setupTextField(placeholder: String) {
        textColor = .white
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor(named: "MyColor")?.cgColor
//        layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//        layer.backgroundColor = UIColor.systemBlue.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 15, height: 15)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
