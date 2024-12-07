//
//  BoxResultsComponent.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 05/12/24.
//

import UIKit

class BoxResultsComponent: UIView {
    var totalBalance: String
    
    private lazy var stack: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.spacing = 10.0
        return variable
    }()

    private lazy var totalBalanceLabel: UILabel = {
        let variable = UILabel().labelTextPrimary()
        variable.translatesAutoresizingMaskIntoConstraints = false
        return variable
    }()
    
    private func setupSubView() {
        addSubview(stack)
        stack.addArrangedSubview(totalBalanceLabel)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    init(totalBalance: String) {
        self.totalBalance = totalBalance
        super.init(frame: .zero)
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
