//
//  SearchViewController.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 19.07.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchString = ""

    let searchField: UITextField = {
        let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        sampleTextField.placeholder = "search"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return sampleTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchField)
        
    }
    
   
    
    
 

}
