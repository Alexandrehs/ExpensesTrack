//
//  ExpenseTableViewHeaderComponent.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import UIKit

protocol ExpenseTableViewHeaderDelegate {
    func tapAddButton()
}

class ExpenseTableViewHeaderComponent: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: ExpenseTableViewHeaderComponent.self)
    var delegate: ExpenseTableViewHeaderDelegate?

    private lazy var stack: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .horizontal
        variable.alignment = .trailing
        return variable
    }()
    
    private lazy var addButton: UIButton = {
        let variable = UIButton()
        variable.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25.0)
        variable.setImage(UIImage(systemName: "plus.circle", withConfiguration: imageConfig), for: .normal)
        variable.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        return variable
    }()
    
    private func setupSubView() {
        addSubview(stack)
        setupStack()
    }
    
    private func setuConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupStack() {
        stack.addArrangedSubview(addButton)
    }
    
    @objc private func tapAddButton() {
        delegate?.tapAddButton()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubView()
        setuConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
