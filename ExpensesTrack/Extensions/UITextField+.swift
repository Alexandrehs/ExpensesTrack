//
//  UITextField+.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import UIKit

extension UITextField {
    func textFieldDefault(placeholder: String, keyboardType: UIKeyboardType) -> UITextField {
        let variable = UITextField()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.placeholder = placeholder
        variable.keyboardType = keyboardType
        variable.textColor = UIColor.textColorPrimary
        variable.borderStyle = .roundedRect
        variable.layer.cornerRadius = 12.0
        return variable
    }
    
    func addDoneButtonOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: self, action: #selector(resignFirstResponder))
        keyboardToolbar.items = [flexibleSpace, doneButton]
        self.inputAccessoryView = keyboardToolbar
    }
}
