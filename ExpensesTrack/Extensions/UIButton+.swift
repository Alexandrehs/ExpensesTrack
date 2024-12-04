//
//  UIButton+.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import UIKit

extension UIButton {
    
    func buttonDefault(title: String) -> UIButton {
        let variable = UIButton()
        variable.setTitle(title, for: .normal)
        variable.setTitleColor(.white, for: .normal)
        variable.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        variable.backgroundColor = UIColor.textColorPrimary
        variable.layer.cornerRadius = 20.0
        variable.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        return variable
    }
}
