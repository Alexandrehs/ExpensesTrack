//
//  UILabel+.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import UIKit

extension UILabel {
    func labelTextPrimary() -> UILabel {
        let variable = UILabel()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.font = .systemFont(ofSize: 24.0, weight: .bold)
        variable.textColor = UIColor(named: AssetsConstants.textColorPrimary)
        return variable
    }
    
    func labelTextSecondary() -> UILabel {
        let variable = UILabel()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.font = .systemFont(ofSize: 16.0, weight: .bold)
        variable.textColor = UIColor(named: AssetsConstants.textColorSecondary)
        return variable
    }
    
    func labelTextTerciary() -> UILabel {
        let variable = UILabel()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.font = .systemFont(ofSize: 16.0, weight: .bold)
        variable.textColor = UIColor(named: AssetsConstants.textColorTerciary)
        return variable
    }
}
