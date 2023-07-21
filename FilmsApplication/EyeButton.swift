//
//  EyeButton.swift
//  FilmsApplication
//
//  Created by Kamil on 19.07.2023.
//

import UIKit

class EyeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEyeButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupEyeButton() {
        setImage(UIImage(systemName: "eye.slash"), for: .normal)
        tintColor = .white
        widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
